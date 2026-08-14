import 'package:equatable/equatable.dart';
import 'daily_forecast_entity.dart';
import 'hourly_forecast_entity.dart';
import 'location_entity.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.location,
    required this.temperature,
    required this.feelsLike,
    required this.weatherCode,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.isDay,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.lastUpdated,
  });

  final LocationEntity location;
  final double temperature;
  final double feelsLike;
  final int weatherCode;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final double visibility;
  final bool isDay;
  final List<HourlyForecastEntity> hourlyForecast;
  final List<DailyForecastEntity> dailyForecast;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [
        location,
        temperature,
        feelsLike,
        weatherCode,
        humidity,
        windSpeed,
        windDirection,
        pressure,
        visibility,
        isDay,
        hourlyForecast,
        dailyForecast,
        lastUpdated,
      ];
}
