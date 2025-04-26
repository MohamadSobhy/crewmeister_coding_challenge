// This file defines list of custom exceptions that can be used throughout the application.
// Each exception class extends the base Exception class and includes a message
// property to provide more context about the error.

class ServerException implements Exception {
  final String message;

  const ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});
}

class UserNotAuthorizedException implements Exception {
  final String message;

  const UserNotAuthorizedException({required this.message});
}

class MaintenanceModeException implements Exception {
  final String message;

  const MaintenanceModeException({required this.message});
}

/// TODO: Add any other needed exceptions
