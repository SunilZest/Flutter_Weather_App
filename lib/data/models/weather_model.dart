import '../../domain/entities/location_entity.dart';
import '../../domain/entities/weather_entity.dart';
import 'daily_forecast_model.dart';
import 'hourly_forecast_model.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.location,
    required super.temperature,
    required super.feelsLike,
    required super.weatherCode,
    required super.humidity,
    required super.windSpeed,
    required super.windDirection,
    required super.pressure,
    required super.visibility,
    required super.isDay,
    required super.hourlyForecast,
    required super.dailyForecast,
    required super.lastUpdated,
  });

  /// Parses the raw JSON body returned by Open-Meteo's `/v1/forecast`
  /// endpoint (with `current`, `hourly`, and `daily` blocks requested)
  /// into a fully-populated [WeatherModel].
  factory WeatherModel.fromJson(
    Map<String, dynamic> json, {
    required LocationEntity location,
  }) {
    final current = json['current'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;

    final currentTime = DateTime.parse(current['time'] as String);

    return WeatherModel(
      location: location,
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      windDirection: (current['wind_direction_10m'] as num?)?.toInt() ?? 0,
      pressure: (current['surface_pressure'] as num).toDouble(),
      visibility: (current['visibility'] as num?)?.toDouble() ?? 10000,
      isDay: (current['is_day'] as num).toInt() == 1,
      hourlyForecast: HourlyForecastModel.listFromJson(
        hourly,
        from: currentTime,
      ),
      dailyForecast: DailyForecastModel.listFromJson(daily),
      lastUpdated: DateTime.now(),
    );
  }
}
