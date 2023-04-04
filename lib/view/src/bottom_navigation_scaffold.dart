import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  int get _currentIndex {
    final location = GoRouter.of(context).location;
    final index = _locationToIndex(location);
    return index;
  }

  int _locationToIndex(String location) {
    switch (location) {
      case '/profile':
        return 1;
      default:
        return 0;
    }
  }

  void _toggleCurrentIndex(int nextIndex) {
    if (nextIndex == _currentIndex) return;
    if (nextIndex != 1) {
      context.go('/notes');
    } else {
      context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _toggleCurrentIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.sticky_note_2),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
