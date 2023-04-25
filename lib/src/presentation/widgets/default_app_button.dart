import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';

class DefaultAppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? buttonColor;
  final Color? shadowColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final double? spreadRadius;
  final double? blurRadius;
  final Offset? offset;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final List<Color>? gradientColors;
  final bool isGradient;
  final bool haveShadow;
  final double? horizontalPadding;

  const DefaultAppButton({
    required this.title,
    required this.onTap,
    this.buttonColor,
    this.textColor,
    this.width,
    this.height,
    this.radius,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.begin,
    this.end,
    this.offset,
    this.gradientColors,
    this.shadowColor,
    this.spreadRadius,
    this.blurRadius,
    this.isGradient = true,
    this.haveShadow = false,
    this.horizontalPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizontalPadding?.w ?? 0),
        width: width ?? 100.w,
        height: height ?? 7.h,
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
            begin: begin ?? Alignment.centerLeft,
            end: end ?? Alignment.centerRight,
            colors: gradientColors ?? [AppColors.grey,AppColors.lightGrey],
          )
              : LinearGradient(
            colors: [
              buttonColor ?? Colors.grey,
              buttonColor ?? Colors.grey,
            ],
          ),
          boxShadow: [
            haveShadow
                ? BoxShadow(
              color: shadowColor ?? Colors.black.withOpacity(0.5),
              spreadRadius: spreadRadius ?? 5,
              blurRadius: blurRadius ?? 5,
              offset: offset ??
                  const Offset(1, 1), // changes position of shadow
            )
                : const BoxShadow(),
          ],
          borderRadius: BorderRadius.circular(radius ?? 50),
          color: buttonColor ?? Colors.grey,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize ?? 15.sp,
              fontWeight: fontWeight ?? FontWeight.w400,
              decoration: textDecoration ?? TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
