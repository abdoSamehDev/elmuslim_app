import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/constants.dart';
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

  List<QuranModel> getQuranPageFromName({
    required List<QuranModel> quranList,
    required String surahName,
    required int pageNo,
  }) {
    List<QuranModel> quran =
        List.from(quranList.where((surah) => surah.ayahs[0].page == pageNo));
    return quran;
  }

  List<AyahModel> getAyahsFromPageNo({
    required List<QuranModel> quranList,
    required int pageNo,
  }) {
    List<AyahModel> ayahs = List.from(quranList
        .expand((surah) => (surah.ayahs.where((ayah) => ayah.page == pageNo))));
    return ayahs;
  }

  String getSurahNameFromPageNo({
    required List<QuranModel> quranList,
    required int pageNo,
  }) {
    List<String> allSurahs = List.of(quranList.map((surah) => surah.name));

    String surahName = Constants.empty;

    List<int> allFirstSurahPageNo =
        List.of(quranList.map((surah) => surah.ayahs[0].page));
// i = 7 (el a3raf)
    //pageNo = 151 (1st a3raf page)
    for (int i = 0; i < allFirstSurahPageNo.length; i++) {
      if (allFirstSurahPageNo[i] == pageNo) {
        surahName = allSurahs[i];
      } else if (allFirstSurahPageNo[i] < pageNo &&
          allFirstSurahPageNo[i + 1] > pageNo) {
        surahName = allSurahs[i];
      } else if (allFirstSurahPageNo[i] > pageNo &&
          allFirstSurahPageNo[i - 1] < pageNo) {
        surahName = allSurahs[i - 1];
      }
    }
return surahName;

  }
}
