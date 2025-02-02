
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


ThemeData darktheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 17.sp),
    ),
    cardTheme: CardTheme(color: Colors.black),
    colorScheme: ColorScheme.dark(
      background: Colors.black,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.grey[800]!,
      brightness: Brightness.dark,
    ));
