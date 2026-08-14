import '../entities/location_entity.dart';
import '../entities/weather_entity.dart';

/// Contract that the data layer must fulfil. The domain layer only
/// depends on this abstraction, never on Dio/Open-Meteo directly.
abstract class WeatherRepository {
  /// Fetch full weather data for a given [lat]/[lon] coordinate pair.
  Future<WeatherEntity> getWeatherByCoordinates({
    required double lat,
    required double lon,
    required String cityName,
    required String country,
    String? admin1,
  });

  /// Resolve a free-text city query into a list of matching locations.
  Future<List<LocationEntity>> searchCity(String query);
}
