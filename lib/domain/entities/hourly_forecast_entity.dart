import 'package:equatable/equatable.dart';

class HourlyForecastEntity extends Equatable {
  const HourlyForecastEntity({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.precipitationProbability,
    required this.isDay,
  });

  final DateTime time;
  final double temperature;
  final int weatherCode;
  final int precipitationProbability;
  final bool isDay;

  @override
  List<Object?> get props =>
      [time, temperature, weatherCode, precipitationProbability, isDay];
}
