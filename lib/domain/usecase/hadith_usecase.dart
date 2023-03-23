import 'package:dartz/dartz.dart';
import 'package:islamic_app/app/error/failure.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/domain/repository/repository.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';

class HadithUseCase implements BaseUseCase<void, List<HadithModel>>{
  final Repository _repository;


  HadithUseCase(this._repository);

  @override
  Future<Either<Failure, List<HadithModel>>> call(_) async {
    return await _repository.getHadithData();
  }
}