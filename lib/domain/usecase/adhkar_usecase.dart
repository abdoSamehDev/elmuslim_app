import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/adhkar_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class AdhkarUseCase implements BaseUseCase<void, List<AdhkarModel>> {
  final Repository _repository = instance<Repository>();

  AdhkarUseCase();

  @override
  Future<Either<Failure, List<AdhkarModel>>> call(_) async {
    return await _repository.getAdhkarData();
  }
}
