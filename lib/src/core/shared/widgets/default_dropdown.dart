import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:sizer/sizer.dart';

class DefaultDropdown<T> extends StatelessWidget {
  const DefaultDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.hint,
    this.hintStyle,
    this.enabled = true,
    this.hasBorder = false,
    this.border,
    this.hasShadow = true,
    this.filled = true,
    this.isCollapsed = true,
    this.showSearchBox = false,
    this.maxHeight,
    this.dropDownKey,
    this.selectedTextStyle,
    this.dropdownTextStyle,
    this.decoration,
    this.fillColor,
    this.disabledFillColor,
    this.borderRadius,
    this.itemAsString,
    this.selectedAlign,
    this.dropdownAlign,
    this.onChanged,
    this.dropdownButtonBuilder,
    this.selectedLeadingWidget,
    this.dropdownLeadingWidget,
    this.onBeforeChange,
  });

  final List<T> items;
  final T? selectedItem;
  final String? hint;
  final TextStyle? hintStyle;
  final BorderSide? border;
  final bool enabled, hasBorder, hasShadow, filled, isCollapsed, showSearchBox;
  final double? maxHeight;
  final Key? dropDownKey;
  final TextStyle? selectedTextStyle;
  final TextStyle? dropdownTextStyle;
  final BoxDecoration? decoration;
  final Color? fillColor;
  final Color? disabledFillColor;
  final BorderRadius? borderRadius;
  final void Function(T?)? onChanged;
  final String Function(T?)? itemAsString;
  final AlignmentGeometry? selectedAlign, dropdownAlign;
  final Widget? dropdownButtonBuilder;
  final Widget Function(BuildContext, T?)? selectedLeadingWidget;
  final Widget Function(BuildContext context, T item, bool isSelected)?
      dropdownLeadingWidget;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  @override
  Widget build(BuildContext context) {
    final relativeMenuHeight = (items.length *
        ((2.sp + 4.h) * 1.6)); //Item count * approximate Item height
    var inputBorder = OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(2.sp),
      borderSide: BorderSide(
        color: enabled ? AppColors.primary : const Color(0xff000000),
        width: 0.5,
      ),
    );
    return DropdownSearch<T>(
      key: dropDownKey,
      enabled: enabled,
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        searchFieldProps: TextFieldProps(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isCollapsed: false,
            constraints: const BoxConstraints(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 0.4.w,
              vertical: 0.2.h,
            ),
          ),
        ),
        itemBuilder: (ctx, item, b) => Container(
          alignment: dropdownAlign ?? AlignmentDirectional.center,
          padding: EdgeInsetsDirectional.fromSTEB(0.5.w, 0.5.h, 0.5.w, 0.5.h),
          child: Row(
            children: [
              dropdownLeadingWidget?.call(ctx, item, b) ?? const SizedBox(),
              Expanded(
                child: Container(
                  alignment: dropdownAlign ?? AlignmentDirectional.center,
                  child: Text(
                    itemAsString != null
                        ? itemAsString!(item)
                        : item.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: dropdownTextStyle ??
                        TextStyle(
                          color: enabled
                              ? AppColors.darkGrey
                              : const Color(0xff636363),
                          fontSize: 3.sp,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        menuProps: MenuProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.sp),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: maxHeight ??
              (relativeMenuHeight > 30.h ? 30.h : relativeMenuHeight),
        ),
      ),
      selectedItem: selectedItem,
      itemAsString: itemAsString,
      dropdownButtonProps: DropdownButtonProps(
        constraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        splashRadius: 12,
        iconSize: 5.sp,
        icon: dropdownButtonBuilder ??
            Icon(
              Icons.keyboard_arrow_down,
              color: enabled ? AppColors.primary : const Color(0xff636363),
              size: 5.sp,
            ),
        selectedIcon: dropdownButtonBuilder ??
            Icon(
              Icons.keyboard_arrow_down,
              color: enabled ? AppColors.primary : const Color(0xff636363),
              size: 5.sp,
            ),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(minHeight: 0, minWidth: 0),
          isCollapsed: isCollapsed,
          fillColor: AppColors.white,
          filled: filled,
          border: inputBorder,
          contentPadding: EdgeInsetsDirectional.only(end: 5.w),
        ),
      ),
      items: items,
      dropdownBuilder: (ctx, value) {
        if (value == null || (value is String && (value == ''))) {
          return Container(
            alignment: selectedAlign ?? AlignmentDirectional.center,
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: FittedBox(
              alignment: selectedAlign ?? AlignmentDirectional.center,
              fit: BoxFit.scaleDown,
              child: Text(
                hint ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: hintStyle ??
                    TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 3.sp,
                    ),
              ),
            ),
          );
        }
        return Container(
          alignment: selectedAlign ?? AlignmentDirectional.center,
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Row(
            children: [
              selectedLeadingWidget?.call(ctx, value) ?? const SizedBox(),
              Expanded(
                child: FittedBox(
                  alignment: selectedAlign ?? AlignmentDirectional.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value is String
                        ? value
                        : itemAsString == null
                            ? value.toString()
                            : itemAsString!(value),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: selectedTextStyle ??
                        TextStyle(
                          color: enabled
                              ? AppColors.darkGrey
                              : const Color(0xff636363),
                          fontSize: 3.sp,
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onChanged: onChanged,
      onBeforeChange: onBeforeChange,
    );
  }
}
