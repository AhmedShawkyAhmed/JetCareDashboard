import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/presentation/widgets/default_app_button.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../business_logic/Corporates_cubit/corporates_cubit.dart';
import '../../styles/app_colors.dart';
import '../../views/loading_view.dart';
import '../../views/row_data.dart';
import '../../widgets/default_text_field.dart';

class CorporatesDesktop extends StatefulWidget {
  const CorporatesDesktop({super.key});

  @override
  State<CorporatesDesktop> createState() => _CorporatesDesktopState();
}

class _CorporatesDesktopState extends State<CorporatesDesktop> {
  TextEditingController search = TextEditingController();
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();


  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubitC = CorporatesCubit.get(context);

    return Scaffold(
      drawerScrimColor: AppColors.transparent,
      key: scaffoldkey,
      backgroundColor: AppColors.green,
      body: Container(
        height: 100.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.h, left: 3.w, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextField(
                      password: false,
                      width: 25.w,
                      height: 5.h,
                      fontSize: 4.sp,
                      color: AppColors.white,
                      bottom: 0.5.h,
                      hintText: 'Name',
                      spreadRadius: 2,
                      blurRadius: 2,
                      shadowColor: AppColors.black.withOpacity(0.05),
                      haveShadow: true,
                      controller: search,
                      onChange: (value){
                        if(value == ""){
                          cubitC.getCorporates();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitC.getCorporates(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                  ],
                ),
              ),
              BlocBuilder<CorporatesCubit, CorporatesState>(
                builder: (context, state) {
                  if (CorporatesCubit.get(context)
                          .getCorporatesResponse
                          ?.corporatesModel ==
                      null) {
                    return SizedBox(
                      height: 79.h,
                      child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                  top: 2.h,
                                  left: 3.2.w,
                                  right: 2.5.w,
                                  bottom: 0.5.h,
                                ),
                                child: LoadingView(
                                  width: 90.w,
                                  height: 5.h,
                                ),
                              )),
                    );
                  } else if (CorporatesCubit.get(context)
                      .getCorporatesResponse!
                      .corporatesModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Corporates Orders Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      itemCount: CorporatesCubit.get(context).listCount,
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
                                      CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .name
                                          .toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
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
                                      CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .phone
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
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
                                      CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .email
                                          .toString(),
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
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
                                      CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .message
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
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
                                      CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .item!
                                          .nameAr
                                          .toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 3.sp),
                                    ),
                                  ],
                                )),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const DefaultText(
                                              text: "Name",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: CorporatesCubit.get(context)
                                                  .corporatesList[index]
                                                  .name
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Phone",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: CorporatesCubit.get(context)
                                                  .corporatesList[index]
                                                  .phone
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Email",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: CorporatesCubit.get(context)
                                                  .corporatesList[index]
                                                  .email
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Order Item",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: CorporatesCubit.get(context)
                                                  .corporatesList[index]
                                                  .item!
                                                  .nameAr
                                                  .toString(),
                                              maxLines: 1,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            const DefaultText(
                                              text: "Message",
                                              maxLines: 1,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            DefaultText(
                                              text: CorporatesCubit.get(context)
                                                  .corporatesList[index]
                                                  .message
                                                  .toString(),
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
                                  if (CorporatesCubit.get(context)
                                          .corporatesList[index]
                                          .adminComment !=
                                      null) {
                                    commentController.text =
                                        CorporatesCubit.get(context)
                                            .corporatesList[index]
                                            .adminComment!;
                                  }
                                });
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
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
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: <Widget>[
                                        DefaultAppButton(
                                          title: "Save",
                                          onTap: () {
                                            CorporatesCubit.get(context)
                                                .corporateAdminComment(
                                              orderId:
                                                  CorporatesCubit.get(context)
                                                      .corporatesList[index]
                                                      .id,
                                              comment: commentController.text,
                                              afterSuccess: () {
                                                setState(() {
                                                  CorporatesCubit.get(context)
                                                          .corporatesList[index]
                                                          .adminComment =
                                                      commentController.text;
                                                });
                                                commentController.clear();
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                          width: 10.w,
                                          height: 4.h,
                                          fontSize: 3.sp,
                                          textColor: AppColors.white,
                                          buttonColor: AppColors.pc,
                                          isGradient: false,
                                          radius: 10,
                                        ),
                                        DefaultAppButton(
                                          title: "Cancel",
                                          onTap: () {
                                            commentController.clear();
                                            Navigator.pop(context);
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
                            // InkWell(
                            //   onTap: cubitC.corporatesList[index].contact == 1
                            //       ? null
                            //       : () {
                            //           CorporatesCubit.get(context)
                            //               .readCorporate(
                            //             id: cubitC.corporatesList[index].id,
                            //             afterSuccess: () {
                            //               setState(() {
                            //                 cubitC.corporatesList[index]
                            //                     .contact = 1;
                            //               });
                            //             },
                            //           );
                            //         },
                            //   child: Icon(
                            //     cubitC.corporatesList[index].contact == 0
                            //         ? Icons.check_circle_outline_outlined
                            //         : Icons.check_circle,
                            //     color: cubitC.corporatesList[index].contact == 0
                            //         ? AppColors.grey
                            //         : AppColors.pc,
                            //   ),
                            // ),
                            SizedBox(
                              width: 2.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
