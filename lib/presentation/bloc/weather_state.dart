import 'package:equatable/equatable.dart';
import '../../domain/entities/weather_entity.dart';

enum WeatherErrorType { noInternet, locationNotFound, server, unknown }

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

/// Loading state. Carries the previous [weather] (if any) so the UI can
/// keep showing stale data with a subtle loading indicator instead of a
/// jarring blank screen, e.g. during pull-to-refresh.
class WeatherLoading extends WeatherState {
  const WeatherLoading({this.previousWeather});

  final WeatherEntity? previousWeather;

  @override
  List<Object?> get props => [previousWeather];
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.weather);

  final WeatherEntity weather;

  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  const WeatherError({
    required this.message,
    required this.type,
    this.previousWeather,
  });

  final String message;
  final WeatherErrorType type;
  final WeatherEntity? previousWeather;

  @override
  List<Object?> get props => [message, type, previousWeather];
}
