/// Base exception for predictable application errors.
class AppException implements Exception {
  AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppException(message: $message, cause: $cause)';
}

/// Exception thrown when an unexpected response is received from the API.
class ApiException extends AppException {
  ApiException(super.message, {super.cause});
}

/// Exception thrown when network communication fails.
class NetworkException extends AppException {
  NetworkException(super.message, {super.cause});
}
