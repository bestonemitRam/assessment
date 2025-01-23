
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


ThemeData lighttheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFfcfcfc),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 17.sp),
  ),
  cardTheme: CardTheme(color: Color(0xfff5f5f5)),
  colorScheme: ColorScheme.dark(
    background:  Color(0xFFfcfcfc),
    primary: Colors.black,
    secondary: Colors.grey[300]!,
    onPrimary: Colors.white,
    brightness: Brightness.light,
  ),
);
