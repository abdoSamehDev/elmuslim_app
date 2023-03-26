import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/presentation/base/base_view_model.dart';

class ZekrBuilderViewModel extends BaseViewModel {

  List<AzkarModel> getAzkarFromCategory(
      {required List<AzkarModel> azkarList, required String category}) {
    List<AzkarModel> azkar =
    List.from(azkarList.where((e) => e.category == category));
    return azkar;
  }
}