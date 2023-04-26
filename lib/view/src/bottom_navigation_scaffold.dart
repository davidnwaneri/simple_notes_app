// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, SystemUiMode, SystemUiOverlayStyle;

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/view/authentication/sign_in/bloc/auth/auth_bloc.dart';

class BottomNavigationScaffold extends StatefulWidget {
  const BottomNavigationScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<BottomNavigationScaffold> createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  final _destinationItems = const <ReusableNavigationDestination>[
    ReusableNavigationDestination(
      icon: Icons.sticky_note_2,
      label: 'Notes',
      location: '/notes',
    ),
    ReusableNavigationDestination(
      icon: Icons.person,
      label: 'Profile',
      location: '/profile',
    ),
  ];

  void _toggleCurrentIndex(int nextIndex) {
    final currentIndex = context.read<CurrentIndexCubit>().state;
    if (nextIndex == currentIndex) return;
    final location = _destinationItems[nextIndex].location;
    context.read<CurrentIndexCubit>().toggleCurrentIndex(nextIndex: nextIndex);
    context.go(location);
  }

  Future<void> _showSignInDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('You are not signed in'),
          actions: [
            TextButton(
              onPressed: () {
                context
                  ..pop() // Pop the dialog
                  ..push('/auth/sign-in');
              },
              child: const Text('Sign in'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CurrentIndexCubit>().state;
    final isUserLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          signedIn: (_) => true,
        );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: widget.child,
        floatingActionButton: (currentIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  if (!isUserLoggedIn) {
                    _showSignInDialog();
                  } else {
                    context.push<void>('/notes/create');
                  }
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: MediaQuery.removeViewPadding(
          context: context,
          removeTop: true,
          child: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: _toggleCurrentIndex,
            destinations: _destinationItems,
          ),
        ),
      ),
    );
  }
}

class ReusableNavigationDestination extends StatelessWidget {
  const ReusableNavigationDestination({
    required this.icon,
    required this.label,
    required this.location,
    super.key,
  });

  final IconData icon;
  final String label;
  final String location;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(icon),
      label: label,
    );
  }
}

class CurrentIndexCubit extends Cubit<int> {
  CurrentIndexCubit() : super(0);

  void toggleCurrentIndex({required int nextIndex}) {
    emit(nextIndex);
  }
}
