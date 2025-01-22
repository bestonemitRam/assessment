import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final double? height;
  final double? width;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final bool isEnabledBorder;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTapOutside;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final InputBorder? enabledBorder;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final double? horizontalContentPadding;
  final double? verticalContentPadding;
  final FocusNode? focusNode;
  final Function()? functionCallOutsideOfTextfield;
  final Widget? counterWidget;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.height,
    this.width,
    this.prefix,
    this.suffix,
    this.validator,
    this.labelText,
    this.keyBoardType,
    this.obscureText = false,
    this.onTapOutside,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.textStyle,
    this.hintStyle,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.enabledBorder,
    this.isEnabledBorder = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.horizontalContentPadding,
    this.verticalContentPadding,
    this.focusNode,
    this.functionCallOutsideOfTextfield,
    this.counterWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode ?? FocusNode(),
      textAlign: textAlign,
      maxLines: maxLines,
      maxLength: maxLength,
      scrollPhysics: AlwaysScrollableScrollPhysics(),
      scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 180),
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      style: textStyle ?? context.bodyTxtStyle,
      obscureText: obscureText,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        counter: counterWidget,
        hintStyle: hintStyle ??
            context.subTitleTxtStyleblack.copyWith(
              color: context.appColor.lightBlackColor,
            ),
        labelStyle: context.subTitleTxtStyleblack
            .copyWith(color: context.appColor.blackColor, fontSize: 16.sp),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalContentPadding ?? 10.w,
          vertical: verticalContentPadding ?? 10.h,
        ),
        fillColor: fillColor ?? context.appColor.greyColor200,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: isEnabledBorder
            ? enabledBorder
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? context.appColor.greyColor400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
              ),
        enabledBorder: isEnabledBorder
            ? enabledBorder ??
                UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: borderColor ?? context.appColor.greyColor400,
                  ),
                )
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? context.appColor.greyColor400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
              ),
        focusedBorder: isEnabledBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? context.appColor.greyColor400,
                ),
              )
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? context.appColor.greyColor400,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
              ),
      ),
      textInputAction: textInputAction,
      onTapOutside: (value) {
        onTapOutside ?? ();
        FocusScope.of(context).unfocus();
      
      },
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
    );
  }
}
