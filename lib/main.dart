import 'package:flutter/material.dart';
import 'package:simple_notes_app/router/app_router.dart';
import 'package:simple_notes_app/theme/app_theme.dart';

void main() {
  runApp(const SimpleNotesApp());
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
    return MaterialApp.router(
      title: 'SimpleNotes',
      debugShowCheckedModeBanner: false,
      theme: _appTheme.lightTheme,
      darkTheme: _appTheme.darkTheme,
      routerConfig: _appRouter.router,
    );
  }
}
