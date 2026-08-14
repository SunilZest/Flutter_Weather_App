import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_by_location.dart';
import '../../domain/usecases/search_city_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required GetWeatherByLocation getWeatherByLocation,
    required SearchCityWeather searchCityWeather,
  })  : _getWeatherByLocation = getWeatherByLocation,
        _searchCityWeather = searchCityWeather,
        super(const WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<SearchWeather>(_onSearchWeather);
    on<RefreshWeather>(_onRefreshWeather);
  }

  final GetWeatherByLocation _getWeatherByLocation;
  final SearchCityWeather _searchCityWeather;

  /// Keeps track of the last successfully resolved coordinates so
  /// [RefreshWeather] knows what to re-fetch.
  ({double lat, double lon, String city, String country, String? admin1})?
      _lastLocation;

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading(previousWeather: _currentWeather()));
    try {
      final weather = await _getWeatherByLocation(
        lat: event.lat,
        lon: event.lon,
        cityName: event.cityName,
        country: event.country,
        admin1: event.admin1,
      );
      _lastLocation = (
        lat: event.lat,
        lon: event.lon,
        city: event.cityName,
        country: event.country,
        admin1: event.admin1,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(_toErrorState(e));
    }
  }

  Future<void> _onSearchWeather(
    SearchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading(previousWeather: _currentWeather()));
    try {
      final weather = await _searchCityWeather(event.query);
      _lastLocation = (
        lat: weather.location.latitude,
        lon: weather.location.longitude,
        city: weather.location.name,
        country: weather.location.country,
        admin1: weather.location.admin1,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(_toErrorState(e));
    }
  }

  Future<void> _onRefreshWeather(
    RefreshWeather event,
    Emitter<WeatherState> emit,
  ) async {
    final loc = _lastLocation;
    if (loc == null) return;
    emit(WeatherLoading(previousWeather: _currentWeather()));
    try {
      final weather = await _getWeatherByLocation(
        lat: loc.lat,
        lon: loc.lon,
        cityName: loc.city,
        country: loc.country,
        admin1: loc.admin1,
      );
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(_toErrorState(e));
    }
  }

  WeatherEntity? _currentWeather() {
    final s = state;
    if (s is WeatherLoaded) return s.weather;
    if (s is WeatherLoading) return s.previousWeather;
    if (s is WeatherError) return s.previousWeather;
    return null;
  }

  WeatherState _toErrorState(Object error) {
    final previous = _currentWeather();
    if (error is NoInternetFailure) {
      return WeatherError(
        message: error.message,
        type: WeatherErrorType.noInternet,
        previousWeather: previous,
      );
    }
    if (error is LocationNotFoundFailure) {
      return WeatherError(
        message: error.message,
        type: WeatherErrorType.locationNotFound,
        previousWeather: previous,
      );
    }
    if (error is ServerFailure) {
      return WeatherError(
        message: error.message,
        type: WeatherErrorType.server,
        previousWeather: previous,
      );
    }
    return WeatherError(
      message: 'Unexpected error occurred',
      type: WeatherErrorType.unknown,
      previousWeather: previous,
    );
  }
}
