import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/domain/models/quran/quran_search_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

import '../../app/utils/di.dart';

class QuranSearchUseCase implements BaseUseCase<void, List<QuranSearchModel>> {
  final Repository _repository = instance<Repository>();

  QuranSearchUseCase();

  @override
  Future<Either<Failure, List<QuranSearchModel>>> call(_) async {
    return await _repository.getQuranSearchData();
  }
}
