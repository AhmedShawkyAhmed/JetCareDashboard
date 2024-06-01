import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final int? maxLines;
  final bool underLined;
  final bool lineThrow;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final TextAlign? align;
  final double letterSpacing;

  const DefaultText({
    required this.text,
    this.textColor,
    this.fontSize,
    this.underLined = false,
    this.lineThrow = false,
    this.maxLines,
    this.fontWeight,
    this.onTap,
    this.align,
    this.letterSpacing = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: align ?? TextAlign.start,
        style: TextStyle(
          letterSpacing: letterSpacing,
          decoration: underLined
              ? TextDecoration.underline
              : lineThrow
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
          color: textColor ?? AppColors.darkGrey,
          fontSize: fontSize ?? 3.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
        textDirection: TextDirection.ltr,
        maxLines: maxLines ?? 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
