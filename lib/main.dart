import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_notes_app/router/app_router.dart';
import 'package:simple_notes_app/theme/app_theme.dart';
import 'package:simple_notes_app/view/settings/theme_bloc/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationSupportDirectory(),
  );

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
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
