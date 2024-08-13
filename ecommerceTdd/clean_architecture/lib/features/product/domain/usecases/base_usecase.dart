import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class BaseUsecase<ResultType, ParamsType> {
  Future<Either<Failure, ResultType>> call(ParamsType params);
}

class NoParams{}
