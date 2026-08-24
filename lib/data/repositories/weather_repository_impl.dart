import '../../core/network/network_info.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required this._remoteDataSource,
    required this._networkInfo,
  });

  final WeatherRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<WeatherEntity> getWeatherByCoordinates({
    required double lat,
    required double lon,
    required String cityName,
    required String country,
    String? admin1,
  }) async {
    if (!await _networkInfo.isConnected) {
      throw const NoInternetFailure();
    }
    return _remoteDataSource.fetchWeather(
      lat: lat,
      lon: lon,
      cityName: cityName,
      country: country,
      admin1: admin1,
    );
  }

  @override
  Future<List<LocationEntity>> searchCity(String query) async {
    if (!await _networkInfo.isConnected) {
      throw const NoInternetFailure();
    }
    if (query.trim().isEmpty) return [];
    return _remoteDataSource.searchLocations(query.trim());
  }
}
