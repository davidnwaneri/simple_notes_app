// 🎯 Dart imports:
import 'dart:collection';

// 📦 Package imports:
import 'package:appwrite/appwrite.dart';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/local_storage_service/local_storage_service.dart';
import 'package:simple_notes_app/remote_service/remote_appwrite_service.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';
import 'package:simple_notes_app/repository/notes_repository.dart';
import 'package:simple_notes_app/repository/repository.dart';
import 'package:simple_notes_app/router/app_router.dart';
import 'package:simple_notes_app/theme/app_theme.dart';
import 'package:simple_notes_app/view/authentication/authentication.dart';
import 'package:simple_notes_app/view/notes/create_note/bloc/create_note_bloc.dart';
import 'package:simple_notes_app/view/notes/delete_note/bloc/delete_note_bloc.dart';
import 'package:simple_notes_app/view/notes/edit_note/bloc/edit_note_bloc.dart';
import 'package:simple_notes_app/view/registration/registration.dart';
import 'package:simple_notes_app/view/settings/theme_bloc/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Client>(
          create: (context) {
            final client = Client();
            return client
                .setEndpoint(const String.fromEnvironment('APPWRITE_ENDPOINT'))
                .setProject(const String.fromEnvironment('APPWRITE_PROJECT_ID'))
                .setSelfSigned();
          },
        ),
        RepositoryProvider<Account>(
          create: (context) => Account(context.read<Client>()),
        ),
        RepositoryProvider<Databases>(
          create: (context) => Databases(context.read<Client>()),
        ),
        RepositoryProvider<SignUpRemoteServiceWithAppWrite>(
          create: (context) => SignUpRemoteServiceWithAppWrite(
            context.read<Account>(),
          ),
        ),
        RepositoryProvider<SignInRemoteServiceWithAppWrite>(
          create: (context) => SignInRemoteServiceWithAppWrite(
            context.read<Account>(),
          ),
        ),
        RepositoryProvider<UserAccountRemoteServiceWithAppWrite>(
          create: (context) => UserAccountRemoteServiceWithAppWrite(
            context.read<Account>(),
          ),
        ),
        RepositoryProvider<LocalStorageServiceWithSharedPref>(
          create: (context) => LocalStorageServiceWithSharedPref(
            plugin: sharedPreferences,
          ),
        ),
        RepositoryProvider<SignInLocalStorageService>(
          create: (context) => SignInLocalStorageService(
            localStorageService:
                context.read<LocalStorageServiceWithSharedPref>(),
          ),
        ),
        RepositoryProvider<UserAccountLocalStorageService>(
          create: (context) => UserAccountLocalStorageService(
            localStorageService:
                context.read<LocalStorageServiceWithSharedPref>(),
          ),
        ),
        RepositoryProvider<UserAccountRepository>(
          create: (context) => UserAccountRepository(
            signInLocalStorageService:
                context.read<SignInLocalStorageService>(),
            localStorageService: context.read<UserAccountLocalStorageService>(),
            remoteService: context.read<UserAccountRemoteServiceWithAppWrite>(),
          ),
        ),
        RepositoryProvider<SignInRepository>(
          create: (context) => SignInRepository(
            localStorageService: context.read<SignInLocalStorageService>(),
            remoteService: context.read<SignInRemoteServiceWithAppWrite>(),
          ),
        ),
        RepositoryProvider<RemoteAppWriteService>(
          create: (context) => RemoteAppWriteService(
            databases: context.read<Databases>(),
          ),
        ),
        RepositoryProvider<NotesRepository>(
          create: (context) => NotesRepository(
            remoteService: context.read<RemoteAppWriteService>(),
            userAccountLocalStorageService:
                context.read<UserAccountLocalStorageService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              authService: context.read<SignUpRemoteServiceWithAppWrite>(),
            ),
          ),
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(
              repository: context.read<SignInRepository>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              repository: context.read<UserAccountRepository>(),
              localStorageForm: LocalStorageForm(
                localStorageServices: UnmodifiableListView([
                  context.read<LocalStorageServiceWithSharedPref>(),
                ]),
              ),
            ),
          ),
          BlocProvider<CreateNoteBloc>(
            create: (context) => CreateNoteBloc(
              repository: context.read<NotesRepository>(),
            ),
          ),
          BlocProvider<EditNoteBloc>(
            create: (context) {
              return EditNoteBloc(
                repository: context.read<NotesRepository>(),
              );
            },
          ),
          BlocProvider<DeleteNoteBloc>(
            create: (context) {
              return DeleteNoteBloc(
                repository: context.read<NotesRepository>(),
              );
            },
          ),
        ],
        child: const SimpleNotesApp(),
      ),
    ),
  );
}

class SimpleNotesApp extends StatefulWidget {
  const SimpleNotesApp({super.key});

  @override
  State<SimpleNotesApp> createState() => _SimpleNotesAppState();
}

class _SimpleNotesAppState extends State<SimpleNotesApp> {
  late final AppThemeWithFlexColorScheme _appTheme;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appTheme = const AppThemeWithFlexColorScheme();
    _appRouter = AppRouter();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    _getCurrentUser();
  }

  void _getCurrentUser() {
    context.read<AuthBloc>().add(const CurrentLoggedInUserFetched());
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = context.watch<ThemeBloc>().state;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SimpleNotes',
      scrollBehavior: const _AppScrollBehavior(),
      theme: _appTheme.lightTheme,
      darkTheme: _appTheme.darkTheme,
      themeMode: selectedTheme.mode,
      routerConfig: _appRouter.router,
    );
  }
}

class _AppScrollBehavior extends ScrollBehavior {
  const _AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
