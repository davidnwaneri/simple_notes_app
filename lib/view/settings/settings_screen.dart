import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_notes_app/core/constants.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/view/settings/theme_bloc/theme_bloc.dart';
import 'package:simple_notes_app/widgets_library/widgets_library.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ReusableSliverAppBar(
            title: 'Settings',
            leading: BackButton(
              onPressed: () {
                context.pop<void>();
              },
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: ThemeSection(),
          ),
        ],
      ),
    );
  }
}

class ThemeSection extends StatefulWidget {
  const ThemeSection({
    super.key,
  });

  @override
  State<ThemeSection> createState() => _ThemeSectionState();
}

class _ThemeSectionState extends State<ThemeSection> {
  void _toggleTheme(ThemeValue? value) {
    if (value != null) {
      context.read<ThemeBloc>().add(ThemeChanged(theme: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTheme = context.watch<ThemeBloc>().state;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Text(
            'Theme',
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.start,
          ),
          ReusableRadioListTile<ThemeValue>(
            value: ThemeValue.light,
            groupValue: selectedTheme,
            onChanged: _toggleTheme,
            label: 'Light',
          ),
          ReusableRadioListTile<ThemeValue>(
            value: ThemeValue.dark,
            groupValue: selectedTheme,
            onChanged: _toggleTheme,
            label: 'Dark',
          ),
          ReusableRadioListTile<ThemeValue>(
            value: ThemeValue.system,
            groupValue: selectedTheme,
            onChanged: _toggleTheme,
            label: 'System',
          ),
        ],
      ),
    );
  }
}

class ReusableRadioListTile<T> extends StatelessWidget {
  const ReusableRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    super.key,
  });

  final T value;
  final T groupValue;
  final ValueChanged<T?>? onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(label),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      controlAffinity: ListTileControlAffinity.trailing,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
