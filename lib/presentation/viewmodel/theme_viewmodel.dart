import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A lightweight ViewModel (implemented as a Cubit) that owns the
/// presentation state for theme mode. Kept separate from [WeatherBloc]
/// since it has nothing to do with weather business logic — this is the
/// "ViewModel" half of the MVVM layer for concerns that don't need full
/// event/state BLoC machinery.
class ThemeViewModel extends Cubit<ThemeMode> {
  ThemeViewModel() : super(ThemeMode.light);

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  bool get isDark => state == ThemeMode.dark;
}
