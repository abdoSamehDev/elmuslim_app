import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';

Widget getSeparator(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: AppPadding.p8.h),
    child: Container(
      width: double.infinity,
      height: AppSize.s1,
      color: Theme.of(context).unselectedWidgetColor,
    ),
  );
}
