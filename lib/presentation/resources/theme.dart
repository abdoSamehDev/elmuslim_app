import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/styles_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    useMaterial3: true,

    //colors
    primaryColor: ColorManager.lightPrimary,
    scaffoldBackgroundColor: ColorManager.lightBackground,
    splashColor: ColorManager.lightSecondary,
    disabledColor: ColorManager.lightGrey,

    //cardView theme
    cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.black,
        elevation: AppSize.s4),

    // appBarTheme
    appBarTheme: AppBarTheme(
      color: ColorManager.lightPrimary,
      centerTitle: true,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightSecondary,
      titleTextStyle:
          getRegularStyle(fontFamily: FontConstants.meQuranFontFamily),
    ),

    //button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.lightPrimary,
      disabledColor: ColorManager.lightGrey,
      splashColor: ColorManager.lightSecondary,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.lightPrimary,
        disabledBackgroundColor: ColorManager.lightGrey,
        foregroundColor: ColorManager.white,
        disabledForegroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        textStyle: getRegularStyle(fontSize: FontSize.s12),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      //Display
      displayLarge: getBoldStyle(fontSize: FontSize.s32),
      displayMedium: getBoldStyle(fontSize: FontSize.s28),
      displaySmall: getBoldStyle(fontSize: FontSize.s24),

      //Headline
      headlineLarge: getSemiBoldStyle(fontSize: FontSize.s20),
      headlineMedium: getSemiBoldStyle(fontSize: FontSize.s18),
      headlineSmall: getSemiBoldStyle(fontSize: FontSize.s16),

      //Title
      titleLarge: getMediumStyle(fontSize: FontSize.s20),
      titleMedium: getMediumStyle(fontSize: FontSize.s18),
      titleSmall: getMediumStyle(fontSize: FontSize.s16),

      //Body
      bodyLarge: getRegularStyle(fontSize: FontSize.s18),
      bodyMedium: getRegularStyle(fontSize: FontSize.s16),
      bodySmall: getRegularStyle(fontSize: FontSize.s12),

      //label
      //text button
      labelLarge:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.gold),
      //button label
      labelMedium: getRegularStyle(fontSize: FontSize.s12),
      //caption
      labelSmall: getRegularStyle(
        fontSize: FontSize.s10,
        color: ColorManager.lightGrey,
      ),
    ),

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.lightGrey,
      ),
      labelStyle: getMediumStyle(
        fontSize: FontSize.s14,
        color: ColorManager.lightGrey,
      ),
      errorStyle: getRegularStyle(
        fontSize: FontSize.s12,
        color: ColorManager.error,
      ),

      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.lightPrimary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}

ThemeData getApplicationLDarkTheme() {
  return ThemeData(
    useMaterial3: true,

    //colors
    primaryColor: ColorManager.darkPrimary,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    splashColor: ColorManager.darkSecondary,
    disabledColor: ColorManager.darkGrey,

    //cardView theme
    cardTheme: const CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.black,
        elevation: AppSize.s4),

    // appBarTheme
    appBarTheme: AppBarTheme(
      color: ColorManager.darkPrimary,
      centerTitle: true,
      elevation: AppSize.s4,
      shadowColor: ColorManager.darkSecondary,
      titleTextStyle:
          getRegularStyle(fontFamily: FontConstants.meQuranFontFamily),
    ),

    //button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.darkPrimary,
      disabledColor: ColorManager.darkGrey,
      splashColor: ColorManager.darkSecondary,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.darkPrimary,
        disabledBackgroundColor: ColorManager.darkGrey,
        foregroundColor: ColorManager.white,
        disabledForegroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        textStyle: getRegularStyle(fontSize: FontSize.s12),
      ),
    ),

    //text theme
    textTheme: TextTheme(
      //Display
      displayLarge: getBoldStyle(fontSize: FontSize.s32),
      displayMedium: getBoldStyle(fontSize: FontSize.s28),
      displaySmall: getBoldStyle(fontSize: FontSize.s24),

      //Headline
      headlineLarge: getSemiBoldStyle(fontSize: FontSize.s20),
      headlineMedium: getSemiBoldStyle(fontSize: FontSize.s18),
      headlineSmall: getSemiBoldStyle(fontSize: FontSize.s16),

      //Title
      titleLarge: getMediumStyle(fontSize: FontSize.s20),
      titleMedium: getMediumStyle(fontSize: FontSize.s18),
      titleSmall: getMediumStyle(fontSize: FontSize.s16),

      //Body
      bodyLarge: getRegularStyle(fontSize: FontSize.s18),
      bodyMedium: getRegularStyle(fontSize: FontSize.s16),
      bodySmall: getRegularStyle(fontSize: FontSize.s12),

      //label
      labelLarge:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.gold),
      //text button
      labelMedium: getRegularStyle(fontSize: FontSize.s12),
      //button label
      labelSmall: getRegularStyle(
          fontSize: FontSize.s10, color: ColorManager.darkGrey), //caption
    ),

    //input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.darkGrey,
      ),
      labelStyle: getMediumStyle(
        fontSize: FontSize.s14,
        color: ColorManager.darkGrey,
      ),
      errorStyle: getRegularStyle(
        fontSize: FontSize.s12,
        color: ColorManager.error,
      ),

      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.darkGrey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.darkPrimary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),

      //error border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
