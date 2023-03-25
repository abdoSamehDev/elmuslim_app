import 'package:flutter/material.dart';
import 'package:islamic_app/app/utils/extentions.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class ZekrBuilderView extends StatelessWidget {
  final AzkarModel azkarModel;

  const ZekrBuilderView({Key? key, required this.azkarModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('''azkarModel.hadith.orEmpty().split('''
            ''')[0].orEmpty(),'''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
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
                      height: AppSize.s2,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                child: getSeparator(context),
              ),
              Text(
                azkarModel.description.orEmpty(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: AppSize.s1_5,
                    color: Theme.of(context).unselectedWidgetColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
