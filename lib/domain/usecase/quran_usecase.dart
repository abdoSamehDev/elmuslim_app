import 'package:dartz/dartz.dart';
import 'package:islamic_app/app/error/failure.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/domain/repository/repository.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';

class QuranUseCase implements BaseUseCase<void, List<QuranModel>>{
  final Repository _repository;


  QuranUseCase(this._repository);

  @override
  Future<Either<Failure, List<QuranModel>>> call(_) async{
return await _repository.getQuranData();
  }
}