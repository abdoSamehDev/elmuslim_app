import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/custom_adhkar/cubit/custom_adhkar_cubit.dart';
import 'package:elmuslim_app/presentation/home/cubit/home_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/routes_manager.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAdhkarView extends StatelessWidget {
  final TextEditingController newDhikrController =
      instance<TextEditingController>();
  final TextEditingController newDhikrTimesController =
      instance<TextEditingController>();
  final GlobalKey<ScaffoldState> scaffoldKey =
      instance<GlobalKey<ScaffoldState>>();
  final GlobalKey<FormState> formKey = instance<GlobalKey<FormState>>();

  CustomAdhkarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomAdhkarCubit, CustomAdhkarState>(
      listener: (context, state) {
        if (state is InsertNewDhikrSuccessState) {
          Navigator.pop(context);
        }
        if (state is ChangeBotSheetState) {
          newDhikrController.clear();
          newDhikrTimesController.clear();
        }
      },
      builder: (context, state) {
        CustomAdhkarCubit cubit = CustomAdhkarCubit.get(context);
        bool isBotSheetShown = cubit.isBotSheetShown;
        HomeCubit homeCubit = HomeCubit.get(context);
        List<CustomAdhkarEntity> customAdhkar = cubit.customAdhkar;
        bool darkMode = homeCubit.darkModeOn(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              AppStrings.customAdhkar.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: ColorManager.gold),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // _showBotSheet(context, darkMode, cubit);
              if (isBotSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit
                      .insertNewDhikr(CustomAdhkarEntity(
                          count: int.parse(newDhikrTimesController.text),
                          dhikr: newDhikrController.text))
                      .then((value) {
                    newDhikrController.clear();
                    newDhikrTimesController.clear();
                  });
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                        (context) => Form(
                              key: formKey,
                              child: Padding(
                                padding: EdgeInsets.all(AppPadding.p16.r),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.addNewDhikr.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    SizedBox(
                                      height: AppSize.s20.h,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.dhikrValidateReturn
                                              .tr();
                                        }
                                        return null;
                                      },
                                      cursorColor: darkMode
                                          ? ColorManager.darkSecondary
                                          : ColorManager.lightPrimary,
                                      controller: newDhikrController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        label: Text(AppStrings.newDhikr.tr()),
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      height: AppSize.s20.h,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.countValidateReturn
                                              .tr();
                                        }
                                        return null;
                                      },
                                      cursorColor: darkMode
                                          ? ColorManager.darkSecondary
                                          : ColorManager.lightPrimary,
                                      controller: newDhikrTimesController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        label: Text(AppStrings
                                            .newDhikrNumberOfRepetitions
                                            .tr()),
                                      ),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        elevation: AppSize.s4.r,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor)
                    .closed
                    .then((value) {
                  cubit.changeBotSheetState(isShown: false);
                });
                cubit.changeBotSheetState(isShown: true);
              }
            },
            backgroundColor: darkMode
                ? ColorManager.darkSecondary
                : ColorManager.lightPrimary,
            child: Icon(
              isBotSheetShown ? Icons.check : Icons.add,
              color: ColorManager.gold,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPadding.p8.r),
            child: ConditionalBuilder(
              condition: customAdhkar.isNotEmpty,
              builder: (BuildContext context) {
                return Column(
                  children: [
                    ListTile(
                      style: ListTileStyle.list,
                      leading: Text(
                        AppStrings.number.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontFamily: FontConstants.uthmanTNFontFamily),
                      ),
                      title: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppPadding.p5.h),
                        child: Text(
                          AppStrings.dhikr.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontFamily: FontConstants.uthmanTNFontFamily),
                        ),
                      ),
                      trailing: Text(
                        AppStrings.count.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontFamily: FontConstants.uthmanTNFontFamily),
                      ),
                    ),
                    // getSeparator(context),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return _customAdhkarIndexItem(
                                cubit: cubit,
                                dhikrId: (index + 1).toString().tr(),
                                dhikrText: customAdhkar[index].dhikr,
                                noOfRepetitions: customAdhkar[index].count,
                                customAdhkar: customAdhkar,
                                context: context);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return getSeparator(context);
                          },
                          itemCount: customAdhkar.length),
                    ),
                  ],
                );
              },
              fallback: (BuildContext context) {
                return Center(
                    child: Text(
                  AppStrings.noCustomAdhkar.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: darkMode
                            ? ColorManager.darkGrey
                            : ColorManager.lightGrey,
                      ),
                  textAlign: TextAlign.center,
                ));
              },
            ),
          ),
        );
      },
    );
  }

  Widget _customAdhkarIndexItem(
      {required CustomAdhkarCubit cubit,
      required String dhikrId,
      required String dhikrText,
      required int noOfRepetitions,
      required List<CustomAdhkarEntity> customAdhkar,
      required BuildContext context}) {
    return Dismissible(
      key: Key(dhikrText),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: ColorManager.error,
        child: const ListTile(
          style: ListTileStyle.list,
          leading: Icon(
            Icons.delete,
            color: ColorManager.white,
          ),
        ),
      ),
      // direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        cubit.delCustomDhikrByDhikrText(dhikrText);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: AppPadding.p5.h),
        child: ListTile(
          style: ListTileStyle.list,
          leading: Padding(
            padding: EdgeInsets.only(top: AppPadding.p5.h),
            child: Text(
              dhikrId,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p5.h),
            child: Text(
              dhikrText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    // fontFamily: FontConstants.meQuranFontFamily,
                    wordSpacing: AppSize.s3.w,
                    letterSpacing: AppSize.s0_1.w,
                  ),
            ),
          ),
          trailing: Text(
            noOfRepetitions.toString().tr(),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.customDhikrRoute,
              arguments: {
                'customDhikrText': dhikrText,
                'noOfRepetitions': noOfRepetitions,
              },
            );
          },
        ),
      ),
    );
  }
}
