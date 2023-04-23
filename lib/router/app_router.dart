// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/repository/repository.dart';
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
            parentNavigatorKey: _shellNavigatorKey,
            path: '/notes',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: NotesScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: ':id/details',
                builder: (context, state) {
                  return NoteDetailsScreen(
                    note: state.extra! as Note,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: ':id/edit',
                builder: (context, state) {
                  return EditNoteScreen(
                    note: state.extra! as Note,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'create',
                builder: (context, state) {
                  return const CreateNoteScreen();
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ProfileScreen(),
              );
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: 'settings',
                pageBuilder: (context, state) {
                  return const MaterialPage(
                    fullscreenDialog: true,
                    child: SettingsScreen(),
                  );
                },
              ),
            ],
          ),
        ],
        builder: (context, state, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CurrentIndexCubit>(
                create: (_) => CurrentIndexCubit(),
              ),
              BlocProvider<FetchNotesBloc>(
                create: (_) => FetchNotesBloc(
                  repository: context.read<FetchNotesRepositoryImpl>(),
                ),
              ),
            ],
            child: BottomNavigationScaffold(child: child),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/auth',
        redirect: (context, state) {
          if (state.path == '/auth/sign-up') {
            return state.path;
          } else if (state.path == '/auth/sign-in') {
            return state.path;
          }
          return null;
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'sign-in',
            builder: (context, state) {
              return const SignInScreen();
            },
          ),
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: 'sign-up',
            builder: (context, state) {
              return const SignUpScreen();
            },
          ),
        ],
      ),
    ],
  );
}
