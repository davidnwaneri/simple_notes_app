import 'dart:collection';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes_app/core/local_storage/local_storage.dart';
import 'package:simple_notes_app/core/local_storage/local_storage_form.dart';
import 'package:simple_notes_app/router/app_router.dart';
import 'package:simple_notes_app/service/service.dart';
import 'package:simple_notes_app/service/src/authentication/sign_in_local_storage_service.dart';
import 'package:simple_notes_app/service/src/authentication/user_account_local_storage_service.dart';
import 'package:simple_notes_app/service/src/sign_in_repository.dart';
import 'package:simple_notes_app/service/src/user_account_repository.dart';
import 'package:simple_notes_app/theme/app_theme.dart';
import 'package:simple_notes_app/view/authentication/authentication.dart';
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
        RepositoryProvider<ISignUpRemoteService>(
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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              authService: context.read<ISignUpRemoteService>(),
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
  late final IAppTheme _appTheme;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appTheme = IAppTheme.withFlexColorScheme();
    _appRouter = AppRouter();

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
      scrollBehavior: const AppScrollBehavior(),
      theme: _appTheme.lightTheme,
      darkTheme: _appTheme.darkTheme,
      themeMode: selectedTheme.mode,
      routerConfig: _appRouter.router,
    );
  }
}

class AppScrollBehavior extends ScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
