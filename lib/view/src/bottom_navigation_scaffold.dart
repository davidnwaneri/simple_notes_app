import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CurrentIndexCubit>().state;
    return Scaffold(
      extendBody: true,
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
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

class CurrentIndexCubit extends Cubit<int> {
  CurrentIndexCubit() : super(0);

  void toggleCurrentIndex({required int nextIndex}) {
    emit(nextIndex);
  }
}
