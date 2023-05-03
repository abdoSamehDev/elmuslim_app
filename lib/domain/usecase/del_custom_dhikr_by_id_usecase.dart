import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class DelCustomDhikrByDhikrTextUseCase implements BaseUseCase<String, void> {
  final Repository _repository = instance<Repository>();

  DelCustomDhikrByDhikrTextUseCase();

  @override
  Future<Either<Failure, void>> call(String dhikr) async {
    return await _repository.delDhikrByDhikrText(dhikr);
  }
}
