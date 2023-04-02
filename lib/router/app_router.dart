import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/service/service.dart';
import 'package:simple_notes_app/view/notes/bloc/fetch_notes_bloc.dart';
import 'package:simple_notes_app/view/view.dart';

class AppRouter {
  static const _initialLocation = '/notes';
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  final GoRouter router = GoRouter(
    initialLocation: _initialLocation,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        routes: [
          GoRoute(
            path: '/notes',
            builder: (context, state) {
              return const NotesScreen();
            },
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) {
              return const SettingsScreen();
            },
          ),
        ],
        builder: (context, state, child) {
          return BlocProvider<FetchNotesBloc>(
            create: (_) => FetchNotesBloc(
              noteService: DummyNoteService(),
            ),
            child: BottomNavigationScaffold(child: child),
          );
        },
      ),
    ],
  );
}
