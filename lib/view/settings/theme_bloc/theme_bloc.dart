import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// EVENT
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.theme});

  final ThemeValue theme;

  @override
  List<Object> get props => [theme];
}

// BLOC
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeValue> {
  ThemeBloc() : super(ThemeValue.system) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeValue> emit) {
    emit(event.theme);
  }

  @override
  ThemeValue? fromJson(Map<String, dynamic> json) {
    return ThemeValue.values.firstWhere((t) => t.toString() == json['theme']);
  }

  @override
  Map<String, dynamic>? toJson(ThemeValue state) {
    final theme = state.toString();
    return {'theme': theme};
  }
}

enum ThemeValue {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  const ThemeValue(this.mode);

  final ThemeMode mode;
}
