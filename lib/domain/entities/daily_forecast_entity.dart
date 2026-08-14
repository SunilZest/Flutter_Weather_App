import 'package:equatable/equatable.dart';

class DailyForecastEntity extends Equatable {
  const DailyForecastEntity({
    required this.date,
    required this.weatherCode,
    required this.maxTemp,
    required this.minTemp,
    required this.sunrise,
    required this.sunset,
    required this.precipitationProbability,
  });

  final DateTime date;
  final int weatherCode;
  final double maxTemp;
  final double minTemp;
  final DateTime sunrise;
  final DateTime sunset;
  final int precipitationProbability;

  @override
  List<Object?> get props =>
      [date, weatherCode, maxTemp, minTemp, sunrise, sunset, precipitationProbability];
}
