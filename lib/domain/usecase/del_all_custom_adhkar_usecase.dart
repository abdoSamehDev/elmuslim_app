import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class DelAllCustomAdhkarUseCase implements BaseUseCase<List<CustomAdhkarEntity>, void> {
  final Repository _repository = instance<Repository>();

  DelAllCustomAdhkarUseCase();

  @override
  Future<Either<Failure, void>> call(List<CustomAdhkarEntity> list) async {
    return await _repository.deleteAll(list);
  }
}
