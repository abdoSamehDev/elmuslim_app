import 'package:dartz/dartz.dart';
import 'package:islamic_app/app/error/failure.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/repository/repository.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';

class AzkarUseCase implements BaseUseCase<void, List<AzkarModel>>{
  final Repository _repository;

  AzkarUseCase(this._repository);

  @override
  Future<Either<Failure, List<AzkarModel>>> call(_) async {
    return await _repository.getAzkarData();
  }
}