import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../domain/entities/failure.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> fetchWeather({
    required double lat,
    required double lon,
    required String cityName,
    required String country,
    String? admin1,
  });

  Future<List<LocationModel>> searchLocations(String query);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<WeatherModel> fetchWeather({
    required double lat,
    required double lon,
    required String cityName,
    required String country,
    String? admin1,
  }) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        ApiConstants.forecastBaseUrl,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current': ApiConstants.currentParams.join(','),
          'hourly': ApiConstants.hourlyParams.join(','),
          'daily': ApiConstants.dailyParams.join(','),
          'timezone': 'auto',
          'forecast_days': 7,
        },
      );

      final data = response.data;
      if (data == null) throw const ServerFailure();

      return WeatherModel.fromJson(
        data,
        location: LocationModel(
          name: cityName,
          country: country,
          admin1: admin1,
          latitude: lat,
          longitude: lon,
        ),
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  @override
  Future<List<LocationModel>> searchLocations(String query) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        ApiConstants.geocodingBaseUrl,
        queryParameters: {
          'name': query,
          'count': 5,
          'language': 'en',
          'format': 'json',
        },
      );

      final results = response.data?['results'] as List?;
      if (results == null) return [];

      return results
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Failure _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return const NoInternetFailure();
      case DioExceptionType.badResponse:
        return const ServerFailure();
      default:
        return const UnknownFailure();
    }
  }
}
