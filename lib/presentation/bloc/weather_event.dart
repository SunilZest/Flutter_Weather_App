import 'package:equatable/equatable.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Fetch weather for a specific coordinate (e.g. default city or GPS location).
class FetchWeather extends WeatherEvent {
  const FetchWeather({
    required this.lat,
    required this.lon,
    required this.cityName,
    required this.country,
    this.admin1,
  });

  final double lat;
  final double lon;
  final String cityName;
  final String country;
  final String? admin1;

  @override
  List<Object?> get props => [lat, lon, cityName, country, admin1];
}

/// Search for a city by free-text query and load its weather.
class SearchWeather extends WeatherEvent {
  const SearchWeather(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// Re-fetch weather for the currently loaded location.
class RefreshWeather extends WeatherEvent {
  const RefreshWeather();
}
