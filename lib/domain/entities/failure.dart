/// Represents a typed failure surfaced to the presentation layer.
/// Keeping this in the domain layer lets the BLoC branch on failure
/// type without knowing about Dio exceptions.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NoInternetFailure extends Failure {
  const NoInternetFailure([super.message = 'No internet connection']);
}

class LocationNotFoundFailure extends Failure {
  const LocationNotFoundFailure([super.message = 'Location not found']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unexpected error occurred']);
}
