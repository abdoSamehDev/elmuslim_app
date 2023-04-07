import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/domain/models/quran/quran_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

import '../../app/utils/di.dart';

class QuranUseCase implements BaseUseCase<void, List<QuranModel>> {
  final Repository _repository = instance<Repository>();

  QuranUseCase();

  @override
  Future<Either<Failure, List<QuranModel>>> call(_) async {
    return await _repository.getQuranData();
  }
}
