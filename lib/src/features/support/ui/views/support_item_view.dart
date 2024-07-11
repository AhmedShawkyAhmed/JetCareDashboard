import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/widgets/default_app_button.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/core/shared/widgets/default_text_field.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:jetboard/src/features/support/cubit/support_cubit.dart';
import 'package:jetboard/src/features/support/data/models/support_model.dart';
import 'package:jetboard/src/features/support/data/requests/support_comment_request.dart';
import 'package:sizer/sizer.dart';

class SupportItemView extends StatefulWidget {
  final  SupportCubit cubit;
  final SupportModel support;

  const SupportItemView({
    required this.cubit,
    required this.support,
    super.key,
  });

  @override
  State<SupportItemView> createState() => _SupportItemViewState();
}

class _SupportItemViewState extends State<SupportItemView> {

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return RowData(
      rowHeight: 8.h,
      data: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID',
              style: TextStyle(fontSize: 3.sp),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
              widget.support.id.toString(),
              style: TextStyle(fontSize: 3.sp),
            ),
          ],
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name',
                style: TextStyle(fontSize: 3.sp),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                widget.support.name!,
                style: TextStyle(fontSize: 3.sp),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact',
                style: TextStyle(fontSize: 3.sp),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                widget.support.contact!,
                style: TextStyle(fontSize: 3.sp),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Subject',
                style: TextStyle(fontSize: 3.sp),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Text(
                widget.support.subject!,
                style: TextStyle(fontSize: 3.sp),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Message',
                style: TextStyle(fontSize: 3.sp),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Message'),
                        content: Text(
                          widget.support.message!,
                          style: TextStyle(
                            fontSize: 3.sp,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  widget.support.message!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 3.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 1.w,
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Details'),
                  content: SizedBox(
                    width: 50.w,
                    height: 35.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const DefaultText(
                          text: "Name",
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                        ),
                        DefaultText(
                          text: widget.support.name.toString(),
                          maxLines: 1,
                          fontWeight: FontWeight.w400,
                        ),
                        const DefaultText(
                          text: "Phone",
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                        ),
                        DefaultText(
                          text: widget.support.contact.toString(),
                          maxLines: 1,
                          fontWeight: FontWeight.w400,
                        ),
                        const DefaultText(
                          text: "Subject",
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                        ),
                        DefaultText(
                          text: widget.support.subject.toString(),
                          maxLines: 1,
                          fontWeight: FontWeight.w400,
                        ),
                        const DefaultText(
                          text: "Message",
                          maxLines: 1,
                          fontWeight: FontWeight.w600,
                        ),
                        DefaultText(
                          text: widget.support.message.toString(),
                          maxLines: 5,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.remove_red_eye),
          color: AppColors.grey,
        ),
        SizedBox(
          width: 1.w,
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (widget.support.adminComment != "") {
                commentController.text =
                    widget.support.adminComment ?? "";
              }
            });
            showDialog<void>(
              context: context,
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
                      onTap: () {
                        widget.cubit.supportComment(
                          request: SupportCommentRequest(
                            id: widget.support.id,
                            comment: commentController.text,
                          ),
                        );
                      },
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
          },
          icon: const Icon(Icons.comment),
          color: AppColors.grey,
        ),
        SizedBox(
          width: 1.w,
        ),
        IconButton(
          onPressed: () {
            widget.cubit.deleteSupport(
              id: widget.support.id,
            );
          },
          icon: const Icon(
            Icons.delete,
            color: AppColors.red,
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
      ],
    );
  }
}
