import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'presentation/viewmodel/theme_viewmodel.dart';
import 'presentation/views/home/home_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeViewModel>(create: (_) => ThemeViewModel()),
        BlocProvider<WeatherBloc>(
          create: (_) => WeatherBloc(
            getWeatherByLocation: sl(),
            searchCityWeather: sl(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeViewModel, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            themeAnimationDuration: const Duration(milliseconds: 400),
            themeAnimationCurve: Curves.easeInOut,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
