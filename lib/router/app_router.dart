import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/main.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const MyHomePage();
        },
      ),
    ],
  );
}
