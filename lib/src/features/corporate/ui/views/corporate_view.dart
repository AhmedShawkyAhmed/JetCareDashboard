import 'package:flutter/material.dart';
import 'package:jetboard/src/core/resources/app_colors.dart';
import 'package:jetboard/src/core/shared/views/comment_view.dart';
import 'package:jetboard/src/core/shared/widgets/default_text.dart';
import 'package:jetboard/src/features/corporate/cubit/corporate_cubit.dart';
import 'package:jetboard/src/core/shared/widgets/row_data.dart';
import 'package:sizer/sizer.dart';

class CorporateView extends StatefulWidget {
  final CorporateCubit cubit;

  const CorporateView({
    required this.cubit,
    super.key,
  });

  @override
  State<CorporateView> createState() => _CorporateViewState();
}

class _CorporateViewState extends State<CorporateView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: ListView.builder(
        itemCount: widget.cubit.corporateOrders!.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 3.2.w,
            right: 2.5.w,
            bottom: 1.h,
          ),
          child: RowData(
            rowHeight: 7.h,
            data: [
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
                      widget.cubit.corporateOrders![index].name ?? "",
                      maxLines: 1,
                      textAlign: TextAlign.center,
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
                      'Phone',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.corporateOrders![index].phone ?? "",
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
                      'Email',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.corporateOrders![index].email ?? "",
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
                      'Message',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.corporateOrders![index].message ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      'Item Name',
                      style: TextStyle(fontSize: 3.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      widget.cubit.corporateOrders![index].item!.nameAr ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 3.sp),
                    ),
                  ],
                ),
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
                                text:
                                    widget.cubit.corporateOrders![index].name ??
                                        "",
                                maxLines: 1,
                                fontWeight: FontWeight.w400,
                              ),
                              const DefaultText(
                                text: "Phone",
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                              DefaultText(
                                text: widget
                                        .cubit.corporateOrders![index].phone ??
                                    "",
                                maxLines: 1,
                                fontWeight: FontWeight.w400,
                              ),
                              const DefaultText(
                                text: "Email",
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                              DefaultText(
                                text: widget
                                        .cubit.corporateOrders![index].email ??
                                    "",
                                maxLines: 1,
                                fontWeight: FontWeight.w400,
                              ),
                              const DefaultText(
                                text: "Order Item",
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                              DefaultText(
                                text: widget.cubit.corporateOrders![index].item!
                                        .nameAr ??
                                    "",
                                maxLines: 1,
                                fontWeight: FontWeight.w400,
                              ),
                              const DefaultText(
                                text: "Message",
                                maxLines: 1,
                                fontWeight: FontWeight.w600,
                              ),
                              DefaultText(
                                text: widget.cubit.corporateOrders![index]
                                        .message ??
                                    "",
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
              CommentView(
                comment: widget.cubit.corporateOrders![index].adminComment!,
                onSave: (value) {
                  widget.cubit.corporateAdminComment(
                    id: widget.cubit.corporateOrders![index].id!,
                    adminComment: value,
                    afterSuccess: () {
                      setState(() {
                        widget.cubit.corporateOrders![index].adminComment =
                            value;
                      });
                    },
                  );
                },
              ),
              SizedBox(
                width: 2.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
