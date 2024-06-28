import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class CommentView extends StatefulWidget {
  final String comment;
  final Function(String value) onSave;

  const CommentView({
    required this.comment,
    required this.onSave,
    super.key,
  });

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  TextEditingController commentController = TextEditingController();

  void _show() {
    showDialog<void>(
      context: NavigationService.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                DefaultTextField(
                  width: 50.w,
                  height: 20.h,
                  hintText: "Write your Comment",
                  textColor: AppColors.mainColor,
                  maxLength: 10000,
                  fontSize: 4.sp,
                  validator: "",
                  maxLine: 5,
                  controller: commentController,
                  password: false,
                  haveShadow: false,
                  color: AppColors.white,
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            DefaultAppButton(
              title: "Save",
              onTap: () => widget.onSave(commentController.text),
              width: 10.w,
              height: 4.h,
              fontSize: 3.sp,
              textColor: AppColors.white,
              buttonColor: AppColors.primary,
              isGradient: false,
              radius: 10,
            ),
            DefaultAppButton(
              title: "Cancel",
              onTap: () {
                commentController.clear();
                NavigationService.pop();
              },
              width: 10.w,
              height: 4.h,
              fontSize: 3.sp,
              textColor: AppColors.mainColor,
              buttonColor: AppColors.lightGrey,
              isGradient: false,
              radius: 10,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    commentController.text = widget.comment;
    super.initState();
  }

  @override
  void dispose() {
    commentController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _show();
      },
      icon: const Icon(Icons.comment),
      color: AppColors.grey,
    );
  }
}
