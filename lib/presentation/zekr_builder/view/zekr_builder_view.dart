import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/extentions.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class ZekrBuilderView extends StatelessWidget {
  final AzkarModel azkarModel;

  const ZekrBuilderView({Key? key, required this.azkarModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('''azkarModel.hadith.orEmpty().split('''
            ''')[0].orEmpty(),''',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorManager.gold
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p8.r),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '''azkarModel.hadith.orEmpty().split('''
                ''')[1].orEmpty()''',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: AppSize.s1_5.h,
                    ),
              ),
              getSeparator(context),
              Text(
                azkarModel.description.orEmpty(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: AppSize.s1.h,
                    color: Theme.of(context).unselectedWidgetColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
