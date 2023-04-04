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
  int _currentIndex = 0;

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
    if (nextIndex == _currentIndex) return;
    final location = _destinationItems[nextIndex].location;
    setState(() {
      _currentIndex = nextIndex;
    });
    context.go(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _toggleCurrentIndex,
        destinations: _destinationItems,
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
