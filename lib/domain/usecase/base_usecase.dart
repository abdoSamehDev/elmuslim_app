import 'package:dartz/dartz.dart';
import 'package:islamic_app/app/error/failure.dart';

abstract class BaseUseCase<In, Out>{

  Future<Either<Failure, Out>> call (In input);
}