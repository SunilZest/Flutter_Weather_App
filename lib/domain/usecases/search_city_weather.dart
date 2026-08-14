import '../entities/failure.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

/// Use case: resolve a free-text city search into weather data by
/// geocoding the query and then fetching the forecast for the best match.
class SearchCityWeather {
  const SearchCityWeather(this._repository);

  final WeatherRepository _repository;

  Future<WeatherEntity> call(String query) async {
    final matches = await _repository.searchCity(query);
    if (matches.isEmpty) {
      throw const LocationNotFoundFailure();
    }
    final best = matches.first;
    return _repository.getWeatherByCoordinates(
      lat: best.latitude,
      lon: best.longitude,
      cityName: best.name,
      country: best.country,
      admin1: best.admin1,
    );
  }
}
