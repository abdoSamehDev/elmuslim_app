import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/presentation/custom_adhkar/cubit/custom_adhkar_cubit.dart';
import 'package:elmuslim_app/presentation/home/cubit/home_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAdhkarView extends StatelessWidget {
  TextEditingController newDhikrController = instance<TextEditingController>();
  TextEditingController newDhikrTimesController =
  instance<TextEditingController>();
  CustomAdhkarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomAdhkarCubit, CustomAdhkarState>(
      listener: (context, state) {},
      builder: (context, state) {
        CustomAdhkarCubit cubit = CustomAdhkarCubit.get(context);
        HomeCubit homeCubit = HomeCubit.get(context);
        bool darkMode = homeCubit.darkModeOn(context);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showBotSheet(context, darkMode, cubit);
              // Navigator.pushNamed(
              //   context,
              //   Routes.customAdhkarRoute,
              // );
            },
            backgroundColor: darkMode
                ? ColorManager.darkSecondary
                : ColorManager.lightPrimary,
            child: const Icon(
              Icons.add,
              color: ColorManager.gold,
            ),
          ),
          body: ConditionalBuilder(condition: cubit.customAdhkar.isNotEmpty,
            builder: (BuildContext context) {
              return const Center(child: Text("Data"));
            },
            fallback: (BuildContext context) {
            return const Center(child: Text("No Data"));
            },),
        );
      },
    );
  }

  void _showBotSheet(BuildContext context, bool darkMode, CustomAdhkarCubit cubit) {
    final formKey = instance<GlobalKey<FormState>>();
    showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        elevation: AppSize.s4.r,
        isScrollControlled: true,
        // isDismissible: true,
        builder: (BuildContext context) {
          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p16.r),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.addNewDhikr.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  TextField(
                    cursorColor: darkMode
                        ? ColorManager.darkSecondary
                        : ColorManager.lightPrimary,
                    controller: newDhikrController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(label: Text(AppStrings.newDhikr.tr())),
                  ),
                  SizedBox(
                    height: AppSize.s10.h,
                  ),
                  TextField(
                    cursorColor: darkMode
                        ? ColorManager.darkSecondary
                        : ColorManager.lightPrimary,
                    controller: newDhikrTimesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text(AppStrings.newDhikrNumberOfRepetitions.tr())),
                  ),
                  SizedBox(
                    height: AppSize.s20.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.insertNewDhikr(CustomAdhkarEntity( count: int.parse(newDhikrTimesController.text), dhikr: newDhikrController.text));
                      },
                      child: Text(AppStrings.add.tr()),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
