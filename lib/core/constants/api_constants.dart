/// Centralized API configuration.
///
/// This app uses **Open-Meteo** (https://open-meteo.com) which is a
/// completely free weather API that does not require an API key.
class ApiConstants {
  ApiConstants._();

  /// Base URL for weather forecast data.
  static const String forecastBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  /// Base URL for geocoding (city name -> lat/long) lookups.
  static const String geocodingBaseUrl =
      'https://geocoding-api.open-meteo.com/v1/search';

  /// Base URL for reverse geocoding (lat/long -> city name).
  static const String reverseGeocodingBaseUrl =
      'https://geocoding-api.open-meteo.com/v1/reverse';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  static const List<String> currentParams = [
    'temperature_2m',
    'relative_humidity_2m',
    'apparent_temperature',
    'is_day',
    'precipitation',
    'weather_code',
    'surface_pressure',
    'wind_speed_10m',
    'wind_direction_10m',
    'visibility',
  ];

  static const List<String> hourlyParams = [
    'temperature_2m',
    'weather_code',
    'precipitation_probability',
    'is_day',
  ];

  static const List<String> dailyParams = [
    'weather_code',
    'temperature_2m_max',
    'temperature_2m_min',
    'sunrise',
    'sunset',
    'precipitation_probability_max',
  ];
}
