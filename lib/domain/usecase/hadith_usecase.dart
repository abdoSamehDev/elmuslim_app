import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/hadith/hadith_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class HadithUseCase implements BaseUseCase<void, List<HadithModel>> {
  final Repository _repository = instance<Repository>();

  HadithUseCase();

  @override
  Future<Either<Failure, List<HadithModel>>> call(_) async {
    return await _repository.getHadithData();
  }
}
