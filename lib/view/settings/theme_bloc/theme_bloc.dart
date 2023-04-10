import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
class ThemeBloc extends Bloc<ThemeEvent, ThemeValue> {
  ThemeBloc() : super(ThemeValue.system) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeValue> emit) {
    emit(event.theme);
  }
}

enum ThemeValue {
  light(ThemeMode.light),
  dark(ThemeMode.dark),
  system(ThemeMode.system);

  const ThemeValue(this.mode);

  final ThemeMode mode;
}
