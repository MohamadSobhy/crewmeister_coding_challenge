import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

/// [UseCase] is a base class for all use cases in the application.
/// It defines a contract for executing a use case with a specific type of
/// parameters and returning a result of a specific type.
/// The [Type] parameter represents the type of the result returned by the use case,
/// while the [Params] parameter represents the type of the input parameters
/// required to execute the use case.
/// The [call] method is the main entry point for executing the use case.
/// It takes the [params] as an argument and returns a [Future] that resolves to
/// an [Either] type, which can either be a [Failure] or the result of the use case.
///
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
