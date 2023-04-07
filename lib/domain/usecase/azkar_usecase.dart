import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/azkar/azkar_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class AzkarUseCase implements BaseUseCase<void, List<AzkarModel>> {
  final Repository _repository = instance<Repository>();

  AzkarUseCase();

  @override
  Future<Either<Failure, List<AzkarModel>>> call(_) async {
    return await _repository.getAzkarData();
  }
}
