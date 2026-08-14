class AppConstants {
  AppConstants._();

  static const String appName = 'Weather App';

  /// Default city shown on first launch (before the user searches
  /// or grants location permission).
  static const String defaultCity = 'Bengaluru';
  static const double defaultLat = 12.9716;
  static const double defaultLon = 77.5946;

  static const List<String> popularCities = [
    'Bengaluru',
    'Mumbai',
    'Delhi',
    'Chennai',
    'London',
    'New York',
  ];
}
