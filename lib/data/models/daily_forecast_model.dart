import '../../domain/entities/daily_forecast_entity.dart';

class DailyForecastModel extends DailyForecastEntity {
  const DailyForecastModel({
    required super.date,
    required super.weatherCode,
    required super.maxTemp,
    required super.minTemp,
    required super.sunrise,
    required super.sunset,
    required super.precipitationProbability,
  });

  static List<DailyForecastModel> listFromJson(Map<String, dynamic> dailyJson) {
    final dates = (dailyJson['time'] as List).cast<String>();
    final codes = (dailyJson['weather_code'] as List).cast<num>();
    final maxTemps = (dailyJson['temperature_2m_max'] as List).cast<num>();
    final minTemps = (dailyJson['temperature_2m_min'] as List).cast<num>();
    final sunrises = (dailyJson['sunrise'] as List?)?.cast<String>();
    final sunsets = (dailyJson['sunset'] as List?)?.cast<String>();
    final precipProb =
        (dailyJson['precipitation_probability_max'] as List?)?.cast<num>();

    return List.generate(dates.length, (i) {
      return DailyForecastModel(
        date: DateTime.parse(dates[i]),
        weatherCode: codes[i].toInt(),
        maxTemp: maxTemps[i].toDouble(),
        minTemp: minTemps[i].toDouble(),
        sunrise: sunrises != null ? DateTime.parse(sunrises[i]) : DateTime.parse(dates[i]),
        sunset: sunsets != null ? DateTime.parse(sunsets[i]) : DateTime.parse(dates[i]),
        precipitationProbability: precipProb != null ? precipProb[i].toInt() : 0,
      );
    });
  }
}
