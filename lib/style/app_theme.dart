import 'package:flutter/material.dart';
import 'package:route_app/style/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: AppColors.black,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: AppColors.labelSmallColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.lightPrimaryColor,
        iconSize: 30,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.lightPrimaryColor,
      size: 40,
    ),
  );


  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkPrimaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimaryColor,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: AppColors.white,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.white,
        iconSize: 30,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white,
      size: 40,
    ),

  );
}
