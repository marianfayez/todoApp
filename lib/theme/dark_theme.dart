import 'dart:ui';

import 'package:flutter/material.dart';

import 'my_theme.dart';

class DarkTheme extends MyTheme{
  @override
  Color get backgroundColor => Color(0xFFF101127);

  @override
  Color get primaryColor => Color(0xFF5669FF);

  @override
  Color get textColor => Color(0xFFF4EBDC);

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
        backgroundColor: backgroundColor,
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