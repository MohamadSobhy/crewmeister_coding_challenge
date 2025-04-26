import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

typedef AppResult<T> = Future<Either<Failure, T>>;
