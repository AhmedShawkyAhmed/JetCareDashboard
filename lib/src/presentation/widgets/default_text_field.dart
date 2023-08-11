import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String? hintText;
  final String? validator;
  final double? height;
  final double? width;
  final Color? color;
  final Color? hintColor;
  final Color? shadowColor;
  final double? spreadRadius;
  final TextAlign? textAlign;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final double? fontSize;
  final double? blurRadius;
  final Offset? offset;
  final int? maxLine;
  final bool? enabled;
  final Widget? prefix;
  final Widget? suffix;
  final double? bottom;
  final double? radius;
  final TextInputType? keyboardType;
  final bool haveShadow;
  final bool password;
  final bool? expands;
  final bool? collapsed;
  final int? maxLength;
  final double? horizontalPadding;
  final Function(String)? onChange;

  const DefaultTextField({
    required this.controller,
    this.hintText,
    this.onTap,
    this.expands,
    this.collapsed,
    this.validator,
    this.hintColor,
    this.maxLength,
    this.height,
    this.color,
    this.textAlign,
    this.textColor,
    this.borderColor,
    this.cursorColor,
    this.fontSize,
    this.width,
    this.enabled,
    this.maxLine,
    this.horizontalPadding,
    this.prefix,
    this.suffix,
    this.bottom,
    this.radius,
    this.keyboardType,
    Key? key,
    this.shadowColor,
    this.spreadRadius,
    this.blurRadius,
    this.offset,
    this.onChange,
    required this.password,
    required this.haveShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding?.w ?? 0),
      height: height ?? 4.h,
      width: width ?? 500.w,
      decoration: BoxDecoration(
        color: color ?? AppColors.lightGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(radius ?? 10),
        border: Border.all(
          color: borderColor ?? AppColors.grey,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   if (validator != "") {
        //     if (value == '') {
        //       return 'You Can\'t leave this field empty';
        //     }
        //     return null;
        //   } else {
        //     return null;
        //   }
        // },
        textAlign: textAlign ?? TextAlign.left,
        keyboardType: keyboardType ?? TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        enabled: enabled ?? true,
        controller: controller,
        expands: expands ?? false,
        maxLength: maxLength,
        textDirection: TextDirection.ltr,
        style: TextStyle(
          color: textColor ?? AppColors.darkGrey,
          fontSize: fontSize ?? 20.sp,
        ),
        cursorColor: cursorColor ?? AppColors.darkGrey,
        maxLines: expands == true ? null : maxLine ?? 1,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hintText ?? "",
          alignLabelWithHint: true,
          hintStyle: TextStyle(
            color: hintColor ??  AppColors.mainColor.withOpacity(0.7),
            fontSize: fontSize ?? 20.sp,
          ),
          border: InputBorder.none,
          hintTextDirection: TextDirection.ltr,
          filled: true,
          isCollapsed: collapsed ?? false,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.only(
            top: 15.sp,
            bottom: 15.sp,
            left: 10.sp,
            right: 10.sp,
          ),
        ),
        obscureText: password,
        onChanged: onChange,
      ),
    );
  }
}
