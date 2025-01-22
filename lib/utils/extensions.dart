import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';



extension ThemeExt on BuildContext {
  /// Theme extensions
  TextStyle get titleStyle => GoogleFonts.nunito(
      color: appColor.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w400);

  TextStyle get titleStyleRegular => GoogleFonts.nunito(
      color: appColor.blackColor, fontSize: 19.sp, fontWeight: FontWeight.w600);

  TextStyle get subTitleStyle => GoogleFonts.nunito(
        fontWeight: FontWeight.w500,
        color: appColor.blackColor,
        fontSize: 18.sp,
      );
       TextStyle get buttonTestStyle => GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        color: appColor.blackColor,
        fontSize: 14.sp,
      );

  TextStyle get subTitleTextStyle => GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        color: appColor.greyColor,
        fontSize: 16.sp,
      );
  TextStyle get subTitleTextStyleBloack => GoogleFonts.nunito(
        fontWeight: FontWeight.w500,
        color: appColor.blackColor,
        fontSize: 14.sp,
      );

  TextStyle get subTitleTxtStyleblack => GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        color: appColor.blackColor,
        fontSize: 13.sp,
      );

  TextStyle get subTitleTxtStyle => GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        color: appColor.greyColor,
        fontSize: 13.sp,
      );

  TextStyle get bodyTxtStyle => GoogleFonts.chivo(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: appColor.blackColor);

  TextStyle get bodyTxtStyleTwo => GoogleFonts.chivo(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: appColor.blackColor,
      decoration: TextDecoration.underline,
      decorationColor: appColor.primary);

  TextStyle get smallTxtStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 10.sp,
      );

  TextStyle get smallTxtStyleBold => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get titleTextStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get cardTitleStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 13.76.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get cardTitleStyleWhite => GoogleFonts.chivo(
        color: appColor.whiteColor,
        fontSize: 13.76.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get dropdownBodyTxtStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get ratingTextStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get noReviewYetTextStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 33.sp,
        fontWeight: FontWeight.w700,
      );

  TextStyle get dropdownTitleTxtStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get yourTicketTextStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 13.5.sp,
        fontWeight: FontWeight.bold,
      );

  TextStyle get priceBodyTxtStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get orderDetailsHeadingTxtStyle => GoogleFonts.chivo(
        color: appColor.blackColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get buttonTxtStyle => GoogleFonts.chivo(
        color: appColor.whiteColor,
        fontSize: 15.59.sp,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bottomNavTextStyle => GoogleFonts.chivo(
        fontSize: 9.sp,
        color: appColor.greyColor500,
        fontWeight: FontWeight.w400,
      );

  TextStyle get headingTextStyle => GoogleFonts.chivo(
        fontSize: 20.sp,
        color: appColor.blackColor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get mainHeadingTextStyle => GoogleFonts.chivo(
        fontSize: 35.sp,
        color: appColor.blackColor,
        fontWeight: FontWeight.w500,
      );

  TextStyle get orderConfirmHeadingTextStyle => GoogleFonts.chivo(
        fontSize: 28.sp,
        color: appColor.blackColor,
        fontWeight: FontWeight.w600,
      );
}

/// Build context extensions
extension ContextExtension on BuildContext
 {
  void to({required Widget screen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  ///Pops all screen until last screen then replaces it with the required screen
  void clearAndPush({required String routePath, Object? args}) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    GoRouter.of(this).pushReplacement(routePath, extra: args);
  }

  /// Get color scheme
  ColorScheme get appColor => Theme.of(this).colorScheme;

  /// Get current height of the screen
  double get height => MediaQuery.of(this).size.height;

  /// Get current height of the screen
  double get width => MediaQuery.of(this).size.width;

  /// Provides safe context
  BuildContext? getSafeContext() {
    if (mounted) {
      return this;
    }
    return null;
  }

  /// show global loader
  void showLoader({bool show = true}) {
    if (mounted) {
      if (show) {
        loaderOverlay.show();
      } else {
        loaderOverlay.hide();
      }
    }
  }
}

extension DateTimeExtension on DateTime? {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  String getFormattedDate({String pattern = "dd-mm-yyyy"}) {
    if (this != null) {
      return DateFormat(pattern).format(this!.toLocal());
    }
    return "";
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(DateTime fromDateTime, DateTime toDateTime) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }
}



extension ColorExt on ColorScheme {
  Color get blackColor =>
      brightness == Brightness.light ? const Color(0xff1A1A1A) : Colors.white38;

  Color get greyColor =>
      brightness == Brightness.light ? const Color(0xff666666) : Colors.white30;

  Color get greyColor500 =>
      brightness == Brightness.light ? Color(0xff6F6B7D) : Colors.white30;

  Color get greyColor400 =>
      brightness == Brightness.light ? Colors.grey.shade400 : Colors.white30;

  Color get greyColor200 =>
      brightness == Brightness.light ? Colors.grey.shade200 : Colors.white12;

  Color get greyColor300 =>
      brightness == Brightness.light ? Colors.grey.shade300 : Colors.white12;

  Color get greyColor100 =>
      brightness == Brightness.light ? Colors.grey.shade100 : Colors.white12;

  Color get greyColor50 =>
      brightness == Brightness.light ? Color(0xffF8F8F8) : Colors.white12;

  Color get lightBlackColor =>
      brightness == Brightness.light ? Colors.black26 : Colors.white30;

  Color get whiteColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;

  Color get backgroundColor =>
      brightness == Brightness.dark ? const Color(0xFF0F0E17) : Colors.white;

  Color get transparent => Colors.transparent;

  Color get redColor => Colors.red;

  Color get primarycolor => Color(0xff228B22);

 
  Color get smallTextColor => brightness == Brightness.light
      ? const Color(0xFF6A6A6A)
      : const Color(0xFF6A6A6A);
  Color get darkGreen => brightness == Brightness.light
      ? const Color(0xFF1D713E)
      : const Color(0xFF07E55E);

  Color get lightGreen => brightness == Brightness.light
      ? const Color(0xFFEDF8F1)
      : Colors.greenAccent;

  Color get yellow =>
      brightness == Brightness.light ? const Color(0xFFE9A706) : Colors.yellow;
}
