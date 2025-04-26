// This file defines list of custom failure classes that can be used throughout the application.
// Each failure class extends the base Failure class and includes a message
// property to provide more context about the error.
// The `Failure` class implements the `Equatable` interface to allow for value comparison
// based on the `message` property. This is useful for error handling and testing.

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class UserNotAuthorizedFailure extends Failure {
  const UserNotAuthorizedFailure({required super.message});
}

class MaintenanceModeFailure extends Failure {
  const MaintenanceModeFailure({required super.message});
}
