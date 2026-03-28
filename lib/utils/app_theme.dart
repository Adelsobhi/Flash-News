import 'package:flash_news/utils/app_styles.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.whiteColor,
      indicatorColor:AppColors.blackColor ,
      appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: AppColors.whiteColor),
      iconTheme: IconThemeData(
        color: AppColors.blackColor
      ),
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16Black,
      labelMedium: AppStyles.medium16Black,
      headlineLarge: AppStyles.medium20Black,
      headlineMedium: AppStyles.bold14Black,
      titleMedium: AppStyles.medium16Black.copyWith(fontSize: 18),
      bodySmall: AppStyles.bold14Black,
      bodyMedium: AppStyles.medium14White,







    ),
      scaffoldBackgroundColor: AppColors.whiteColor,


  );
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.blackColor,
     indicatorColor:AppColors.whiteColor ,
    appBarTheme: AppBarTheme(centerTitle: true,backgroundColor: AppColors.blackColor,),
    iconTheme: IconThemeData(
        color: AppColors.whiteColor
    ),
    textTheme: TextTheme(
        labelLarge: AppStyles.bold16White,
        labelMedium: AppStyles.medium16White,
          headlineLarge: AppStyles.medium20White,
        headlineMedium: AppStyles.bold14White,
        titleMedium: AppStyles.medium16White.copyWith(fontSize: 18),
      bodySmall: AppStyles.bold14White,
      bodyMedium: AppStyles.medium14White,





    ),
    scaffoldBackgroundColor: AppColors.blackColor,

  );
}