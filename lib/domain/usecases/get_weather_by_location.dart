import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

/// Use case: fetch the full weather payload for a specific coordinate.
class GetWeatherByLocation {
  const GetWeatherByLocation(this._repository);

  final WeatherRepository _repository;

  Future<WeatherEntity> call({
    required double lat,
    required double lon,
    required String cityName,
    required String country,
    String? admin1,
  }) {
    return _repository.getWeatherByCoordinates(
      lat: lat,
      lon: lon,
      cityName: cityName,
      country: country,
      admin1: admin1,
    );
  }
}
