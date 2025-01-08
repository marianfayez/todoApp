import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:todo/theme/my_theme.dart';

class LightTheme extends MyTheme{
  @override
  Color get backgroundColor => Color(0xFFF2FEFF);

  @override
  Color get primaryColor => Color(0xFF5669FF);

  @override
  Color get textColor => Color(0xFF1C1C1C);

  @override
  ThemeData get themeData => ThemeData(
    primaryColor: primaryColor,
    hintColor: backgroundColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: backgroundColor
    ),
    scaffoldBackgroundColor: backgroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed
      ),
    textTheme: TextTheme(
      titleSmall:TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: textColor),
      titleMedium:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: primaryColor),
      titleLarge:TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: primaryColor),
      headlineSmall:TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: primaryColor),
      headlineMedium:TextStyle(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.white),

    )
  );
  
}