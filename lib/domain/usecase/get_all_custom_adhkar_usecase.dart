import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class GetAllCustomAdhkarUseCase implements BaseUseCase<void, List<CustomAdhkarEntity>> {
  final Repository _repository = instance<Repository>();

  GetAllCustomAdhkarUseCase();

  @override
  Future<Either<Failure, List<CustomAdhkarEntity>>> call(_) async {
    return await _repository.getAllCustomAdhkar();
  }
}
