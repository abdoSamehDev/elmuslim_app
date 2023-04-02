import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';
import 'package:islamic_app/domain/usecase/quran_usecase.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  final QuranUseCase _quranUseCase = instance<QuranUseCase>();

  QuranCubit() : super(QuranInitial());

  static QuranCubit get(context) => BlocProvider.of(context);

  Future getQuranData() async {
    emit(QuranGetDataLoadingState());
    final result = await _quranUseCase(const NoParameters());
    result.fold((l) => emit(QuranGetDataErrorState(l.message)),
        (r) => emit(QuranGetDataSuccessState(r)));
  }

  List<AyahModel> getAyahsFromPageNo({
    required List<QuranModel> quranList,
    required int pageNo,
  }) {
    List<AyahModel> ayahs = List.from(quranList
        .expand((surah) => (surah.ayahs.where((ayah) => ayah.page == pageNo))));
    return ayahs;
  }

  List<QuranModel> getPageSurahs({
    required List<QuranModel> quran,
    required int pageNo,
  }) {
    List<QuranModel> pageSurahsNames = [];
    for (var i = 0; i < quran.length; i++) {
      final surah = quran[i];
      final List<AyahModel> ayahs = surah.ayahs;
      for (var ayah in ayahs) {
        if (ayah.page == pageNo) {
          pageSurahsNames.add(surah);
        }
      }
    }
    return pageSurahsNames.toSet().toList();
  }
}
