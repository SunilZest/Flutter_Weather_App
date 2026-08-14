import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.admin1,
  });

  final String name;
  final String country;
  final String? admin1;
  final double latitude;
  final double longitude;

  String get displayName =>
      admin1 != null && admin1!.isNotEmpty && admin1 != name
          ? '$name, $admin1, $country'
          : '$name, $country';

  @override
  List<Object?> get props => [name, country, admin1, latitude, longitude];
}
