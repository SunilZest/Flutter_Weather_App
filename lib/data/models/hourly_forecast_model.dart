import '../../domain/entities/hourly_forecast_entity.dart';

class HourlyForecastModel extends HourlyForecastEntity {
  const HourlyForecastModel({
    required super.time,
    required super.temperature,
    required super.weatherCode,
    required super.precipitationProbability,
    required super.isDay,
  });

  /// Builds a list of hourly forecasts from the raw "hourly" object
  /// returned by the Open-Meteo forecast endpoint, filtering to the
  /// next [limit] hours starting from [from].
  static List<HourlyForecastModel> listFromJson(
    Map<String, dynamic> hourlyJson, {
    required DateTime from,
    int limit = 24,
  }) {
    final times = (hourlyJson['time'] as List).cast<String>();
    final temps = (hourlyJson['temperature_2m'] as List).cast<num>();
    final codes = (hourlyJson['weather_code'] as List).cast<num>();
    final precipProb =
        (hourlyJson['precipitation_probability'] as List?)?.cast<num>();
    final isDayList = (hourlyJson['is_day'] as List?)?.cast<num>();

    final result = <HourlyForecastModel>[];
    for (var i = 0; i < times.length; i++) {
      final time = DateTime.parse(times[i]);
      if (time.isBefore(from.subtract(const Duration(minutes: 1)))) continue;
      result.add(
        HourlyForecastModel(
          time: time,
          temperature: temps[i].toDouble(),
          weatherCode: codes[i].toInt(),
          precipitationProbability: precipProb != null ? precipProb[i].toInt() : 0,
          isDay: isDayList != null ? isDayList[i].toInt() == 1 : true,
        ),
      );
      if (result.length >= limit) break;
    }
    return result;
  }
}
