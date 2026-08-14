import 'package:get_it/get_it.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/usecases/get_weather_by_location.dart';
import '../../domain/usecases/search_city_weather.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

final GetIt sl = GetIt.instance;

/// Registers every dependency used across the app. Called once from
/// `main()` before `runApp`. Keeping this centralized is what lets the
/// BLoC/ViewModel layer stay ignorant of concrete implementations.
void setupServiceLocator() {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Data
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Domain / use cases
  sl.registerLazySingleton(() => GetWeatherByLocation(sl()));
  sl.registerLazySingleton(() => SearchCityWeather(sl()));
}
