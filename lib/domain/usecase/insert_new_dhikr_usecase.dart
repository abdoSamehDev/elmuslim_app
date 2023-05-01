import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class InsertNewDhikrUseCase implements BaseUseCase<CustomAdhkarEntity, void> {
  final Repository _repository = instance<Repository>();

  InsertNewDhikrUseCase();

  @override
  Future<Either<Failure, void>> call(CustomAdhkarEntity dhikr) async {
    return await _repository.insertDhikr(dhikr);
  }
}
