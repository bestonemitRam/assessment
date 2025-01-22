
import 'package:assessment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ButtonElevated extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? height;
  final double? elevation;
  final double? width;
  final Color? backgroundColor;
  final bool enabled;
  final OutlinedBorder? shape;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Icon? leadingIcon;
  final Icon? suffixIcon;

  //final Color? disabledBackgroundColor;

  const ButtonElevated({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height,
    this.width,
    this.elevation,
    this.backgroundColor,
    //this.disabledBackgroundColor,
    this.textColor,
    this.enabled = true,
    this.borderColor,
    this.shape,
    this.borderRadius,
    this.fontSize,
    this.padding,
    this.suffixIcon,
    this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: borderColor ?? context.appColor.whiteColor),
            elevation: elevation ?? 2,
            padding: padding ?? EdgeInsets.symmetric(horizontal: 5.w),
            backgroundColor: enabled
                ? (backgroundColor ?? context.appColor.primary)
                : context.appColor.greyColor200,
            //disabledBackgroundColor??
            minimumSize: Size(width ?? constraints.minWidth, height ?? 40.h),
            shape: shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
          ),
          child: FittedBox(
            child: Row(
              children: [
                if (leadingIcon != null) leadingIcon!,
                if (leadingIcon != null) Gap(5.w),
                Text(
                  text,
                  style: context.titleTextStyle.copyWith(
                    color: textColor ?? context.appColor.whiteColor,
                    fontSize: fontSize ?? 16.sp,
                  ),
                ),
                if (suffixIcon != null) Gap(5.w),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          ),
     
     
        );
      },
    );
  }
}
