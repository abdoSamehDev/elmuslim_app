import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/resources/values.dart';

Widget getSeparator(BuildContext context){
  return Container(
    width: double.infinity,
    height: AppSize.s1,
    color: Theme.of(context).unselectedWidgetColor,
  );
}
