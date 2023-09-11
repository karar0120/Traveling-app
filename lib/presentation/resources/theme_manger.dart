import 'package:flutter/material.dart';

import 'Color_Manger.dart';
import 'Fonts_Manger.dart';
import 'style_manger.dart';
import 'values_manger.dart';
ThemeData getAppTheme() {
  return ThemeData(
    /// Main Color Theme
    primaryColor: ColorManger.primary,
    primaryColorLight: ColorManger.lightGray,
    primaryColorDark: ColorManger.darkPrimary,
    disabledColor: ColorManger.grey1,
    splashColor: ColorManger.lightPrimary,
    ///CardView theme
    cardTheme: const CardTheme(
      color: ColorManger.white,
      shadowColor: ColorManger.gray,
      elevation: AppSize.s4,
    ),

    /// app bar theme
    appBarTheme: AppBarTheme(
      shadowColor: ColorManger.lightPrimary,
        color: ColorManger.primary,
        centerTitle: true,
        elevation: AppSize.s4,
        titleTextStyle: getRegularStyle(
            color: ColorManger.white,
            fontSize: FontSizeManger.s16)),

    /// button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      splashColor: ColorManger.lightPrimary,
      disabledColor: ColorManger.grey1,
      buttonColor: ColorManger.primary,
    ),

    ///elevatedButtonTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
            color: ColorManger.white, fontSize: FontSizeManger.s17),
        backgroundColor: ColorManger.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),

    ///text theme
    textTheme: TextTheme(
        displayLarge: getSemiBoldStyle(
            color: ColorManger.darkGray, fontSize: FontSizeManger.s16),
        headlineLarge: getSemiBoldStyle(
            color: ColorManger.darkGray, fontSize: FontSizeManger.s16),
        headlineMedium: getRegularStyle(
            color: ColorManger.darkGray, fontSize: FontSizeManger.s14),
        titleMedium:
        getMediumStyle(color: ColorManger.primary, fontSize: FontSizeManger.s16),
        titleSmall:
        getRegularStyle(color: ColorManger.white, fontSize: FontSizeManger.s16),
        bodyLarge: getRegularStyle(color: ColorManger.grey1),
        bodySmall: getRegularStyle(color: ColorManger.gray),
        bodyMedium: getRegularStyle(color: ColorManger.grey2, fontSize: FontSizeManger.s12),
        labelSmall:
        getBoldStyle(color: ColorManger.primary, fontSize: FontSizeManger.s12)),

    /// input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(
          AppPadding.p8,
        ),
        hintStyle: getRegularStyle(
            color: ColorManger.gray,
            fontSize: FontSizeManger.s14),
        labelStyle: getMediumStyle(
            color: ColorManger.gray, fontSize: FontSizeManger.s14),
        errorStyle:getRegularStyle(
            color: ColorManger.error),


        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManger.gray,
              width: AppSize.s1_5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManger.gray,
              width: AppSize.s1_5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManger.error,
              width: AppSize.s1_5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManger.primary,
              width: AppSize.s1_5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))),
  );

}
