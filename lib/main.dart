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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
