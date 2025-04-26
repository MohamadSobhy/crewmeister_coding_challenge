import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../generated/l10n.dart';
import '../api/typedefs.dart';
import '../errors/failures.dart';
import '../network/network_info.dart';
import 'exceptions.dart';

/// [RepositoryCallHandler] is a handler class used to handle all repositories
/// methods calls throughout the whole project.
///
/// it has a [handleCall] method that returns the result of the method call when there is no
/// [Exception] happens.
class RepositoryCallHandler {
  final NetworkInfo networkInfo;

  RepositoryCallHandler({required this.networkInfo});

  /// handles all types of [Exception]s that may happen through the whole project.
  ///
  /// accepts a function call as an argument [methodCall]
  ///
  /// returns the result of the [methodCall] when there is no [Exception] happens.
  AppResult<T> handleCall<T>(
    dynamic methodCall, {
    bool ignoreNetworkCheck = false,
    Exception? additionalCheckType,
  }) async {
    if (await networkInfo.isConnected || ignoreNetworkCheck) {
      try {
        final result = await methodCall();

        return Right(result);
      } on ServerException catch (err) {
        return Left(ServerFailure(message: err.message));
      } on CacheException catch (err) {
        return Left(CacheFailure(message: err.message));
      } on SocketException catch (_) {
        return Left(
          NetworkFailure(message: S.current.no_internet_connection_msg),
        );
      } on NetworkException catch (_) {
        return Left(
          NetworkFailure(message: S.current.no_internet_connection_msg),
        );
      } on UserNotAuthorizedException catch (err) {
        return Left(UserNotAuthorizedFailure(message: err.message));
      } on MaintenanceModeException catch (err) {
        return Left(MaintenanceModeFailure(message: err.message));
      } catch (err) {
        log(err.toString(), name: 'API_BASE_HANDLER');
        print(err);

        try {
          return Left(ServerFailure(message: (err as dynamic).message));
        } on NoSuchMethodError catch (_) {
          return Left(ServerFailure(message: err.toString()));
        }
      }
    } else {
      return Left(
        NetworkFailure(message: S.current.no_internet_connection_msg),
      );
    }
  }
}
