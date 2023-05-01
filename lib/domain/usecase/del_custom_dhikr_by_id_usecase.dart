import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';

class DelCustomDhikrByIdUseCase implements BaseUseCase<int, void> {
  final Repository _repository = instance<Repository>();

  DelCustomDhikrByIdUseCase();

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await _repository.delDhikrById(id);
  }
}