import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/business_logic/global_cubit/global_cubit.dart';
import 'package:jetboard/src/business_logic/packages_cubit/packages_cubit.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/constants_variables.dart';
import 'package:jetboard/src/data/network/requests/packages_request.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/views/row_data.dart';
import 'package:jetboard/src/presentation/widgets/default_dropdown.dart';
import 'package:jetboard/src/presentation/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../views/add_items.dart';
import '../../views/loading_view.dart';
import '../../views/view_items.dart';
import '../../widgets/default_app_button.dart';
import '../../widgets/default_text_field.dart';

class PackagesDesktop extends StatefulWidget {
  const PackagesDesktop({super.key});

  @override
  State<PackagesDesktop> createState() => _PackagesDesktopState();
}

class _PackagesDesktopState extends State<PackagesDesktop> {
  TextEditingController search = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController descriptionEn = TextEditingController();
  TextEditingController descriptionAr = TextEditingController();
  TextEditingController price = TextEditingController();
  int currentIndex = 0;
  List<bool> isChecked = List.generate(2000, (index) => false);
  List<int> itemsId = [];

  @override
  Widget build(BuildContext context) {
    var cubit = GlobalCubit.get(context);
    var cubitP = PackagesCubit.get(context);
    return Scaffold(
      drawerScrimColor: AppColors.transparent,
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
                      onChange: (value) {
                        if (value == "") {
                          cubitP.getPackages();
                        }
                      },
                      suffix: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          cubitP.getPackages(keyword: search.text);
                          printResponse(search.text);
                        },
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    BlocBuilder<PackagesCubit, PackagesState>(
                      builder: (context, state) {
                        return PackagesCubit.get(context).categoryTypes.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                width: 8.w,
                                height: 5.h,
                                child: DefaultDropdown<String>(
                                  hint: "Package",
                                  showSearchBox: true,
                                  selectedItem: package,
                                  items: ['All'] + cubitP.categoryTypes,
                                  onChanged: (val) {
                                    setState(() {
                                      PackagesCubit.get(context).getPackages(
                                          type: val == "All" ? " " : val);
                                      package = val!;
                                    });
                                  },
                                ),
                              );
                      },
                    ),
                    const Spacer(),
                    DefaultAppButton(
                      width: 8.w,
                      height: 5.h,
                      offset: const Offset(0, 0),
                      spreadRadius: 2,
                      blurRadius: 2,
                      radius: 10,
                      gradientColors: const [
                        AppColors.green,
                        AppColors.lightgreen,
                      ],
                      fontSize: 4.sp,
                      haveShadow: false,
                      title: "Add",
                      onTap: () {
                        setState(() {
                          cubit.isedit = false;
                          nameEn.clear();
                          descriptionEn.clear();
                          nameAr.clear();
                          descriptionAr.clear();
                          price.clear();
                          dropItemsItem = "";
                          imageApp = null;
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
                                    const DefaultText(
                                        text: "Add New Package",
                                        align: TextAlign.center),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: nameAr.text,
                                        password: false,
                                        controller: nameAr,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Arabic Name',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: nameEn.text,
                                        password: false,
                                        controller: nameEn,
                                        height: 5.h,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'English Name',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: SizedBox(
                                        height: 20.h,
                                        child: DefaultTextField(
                                          validator: descriptionAr.text,
                                          password: false,
                                          controller: descriptionAr,
                                          height: 20.h,
                                          keyboardType: TextInputType.multiline,
                                          fontSize: 3.sp,
                                          haveShadow: true,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          maxLine: 7,
                                          collapsed: true,
                                          color: AppColors.white,
                                          shadowColor:
                                              AppColors.black.withOpacity(0.05),
                                          hintText: 'Arabic Description',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: descriptionEn.text,
                                        password: false,
                                        controller: descriptionEn,
                                        height: 20.h,
                                        keyboardType: TextInputType.multiline,
                                        fontSize: 3.sp,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        maxLine: 7,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'English Description',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultTextField(
                                        validator: price.text,
                                        password: false,
                                        height: 7.h,
                                        fontSize: 4.sp,
                                        controller: price,
                                        haveShadow: true,
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        color: AppColors.white,
                                        shadowColor:
                                            AppColors.black.withOpacity(0.05),
                                        hintText: 'Price',
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h, left: 3.w, right: 3.w),
                                      child: DefaultDropdown<String>(
                                        hint: "Category",
                                        showSearchBox: true,
                                        selectedItem: dropItemsItem == ''
                                            ? cubitP.categoryTypes.last
                                            : dropItemsItem,
                                        items: cubitP.categoryTypes,
                                        onChanged: (val) {
                                          setState(() {
                                            dropItemsItem = val!;
                                          });
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h, left: 3.w, right: 3.w),
                                        child: BlocBuilder<PackagesCubit,
                                            PackagesState>(
                                          builder: (context, state) {
                                            return Container(
                                              height: 20.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: cubit.isedit
                                                  ? Stack(
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: imageApp ==
                                                                    null
                                                                ? cubitP.fileResult ==
                                                                        null
                                                                    ? Container()
                                                                    : Image
                                                                        .memory(
                                                                        cubitP
                                                                            .fileResult!
                                                                            .files
                                                                            .first
                                                                            .bytes!,
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        width:
                                                                            100.w,
                                                                      )
                                                                : Image.network(
                                                                    imageDomain +
                                                                        imageApp!,
                                                                    fit: BoxFit
                                                                        .fitWidth,
                                                                    width:
                                                                        100.w,
                                                                  )),
                                                        Container(
                                                          height: 4.h,
                                                          width: 3.w,
                                                          decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20)),
                                                              color: AppColors
                                                                  .green),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                cubitP
                                                                    .pickImage();
                                                                imageApp = null;
                                                                printSuccess(cubitP
                                                                    .fileResult
                                                                    .toString());
                                                              },
                                                              icon: const Icon(
                                                                Icons.edit,
                                                                color: AppColors
                                                                    .white,
                                                              )),
                                                        )
                                                      ],
                                                    )
                                                  : cubitP.fileResult == null
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons.image),
                                                            TextButton(
                                                                onPressed: () {
                                                                  cubitP
                                                                      .pickImage();
                                                                },
                                                                child: const Text(
                                                                    'Select Image'))
                                                          ],
                                                        )
                                                      : Stack(
                                                          children: [
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image
                                                                    .memory(
                                                                  cubitP
                                                                      .fileResult!
                                                                      .files
                                                                      .first
                                                                      .bytes!,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                  width: 100.w,
                                                                )),
                                                            Container(
                                                              height: 4.h,
                                                              width: 3.w,
                                                              decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                  color: AppColors
                                                                      .green),
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    cubitP
                                                                        .pickImage();
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.edit,
                                                                    color: AppColors
                                                                        .white,
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              actions: <Widget>[
                                DefaultAppButton(
                                  title: "Save",
                                  onTap: () {
                                    cubitP.addPackages(
                                        packagesRequest: PackagesRequest(
                                      nameEn: nameEn.text,
                                      descriptionEn: descriptionEn.text,
                                      nameAr: nameAr.text,
                                      descriptionAr: descriptionAr.text,
                                      price: double.parse(price.text),
                                      type: dropItemsItem,
                                    ));
                                    nameEn.clear();
                                    descriptionEn.clear();
                                    nameAr.clear();
                                    descriptionAr.clear();
                                    price.clear();
                                    cubitP.fileResult = null;
                                    dropItemsItem = '';
                                    Navigator.pop(context);
                                  },
                                  width: 10.w,
                                  height: 4.h,
                                  fontSize: 3.sp,
                                  textColor: AppColors.white,
                                  buttonColor: AppColors.pc,
                                  isGradient: false,
                                  radius: 10,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DefaultAppButton(
                                  title: "Cancel",
                                  onTap: () {
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
                    )
                  ],
                ),
              ),
              BlocBuilder<PackagesCubit, PackagesState>(
                builder: (context, state) {
                  if (PackagesCubit.get(context)
                          .getPackagesResponse
                          ?.packagesModel ==
                      null) {
                    return Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: SizedBox(
                        height: 79.h,
                        child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.5.h, left: 3.2.w, right: 2.5),
                                  child: LoadingView(
                                    width: 90.w,
                                    height: 5.h,
                                  ),
                                )),
                      ),
                    );
                  } else if (PackagesCubit.get(context)
                      .getPackagesResponse!
                      .packagesModel!
                      .isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: DefaultText(
                        text: "No Packages Found !",
                        fontSize: 5.sp,
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: SizedBox(
                      height: 90.h,
                      child: ListView.builder(
                        itemCount: cubitP.listCount,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, left: 3.2.w, right: 2.5.w, bottom: 1.h),
                          child: RowData(
                            rowHeight: 8.h,
                            data: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'English Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].nameEn
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
                                        'Arabic Name',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].nameAr
                                            .toString(),
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
                                        'Price',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].price
                                            .toString(),
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
                                        'Type',
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        cubitP.packageList[index].type
                                            .toString(),
                                        style: TextStyle(fontSize: 3.sp),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    imageDomain +
                                        cubitP.packageList[index].image,
                                    height: 6.h,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              SizedBox(
                                height: 3.h,
                                child: CircleAvatar(
                                  backgroundColor:
                                      cubitP.packageList[index].active == 1
                                          ? AppColors.green
                                          : AppColors.red,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Switch(
                                  value: cubitP.packageList[index].active == 1
                                      ? true
                                      : false,
                                  activeColor: AppColors.green,
                                  activeTrackColor: AppColors.lightgreen,
                                  inactiveThumbColor: AppColors.red,
                                  inactiveTrackColor: AppColors.lightGrey,
                                  splashRadius: 3.0,
                                  onChanged: (value) {
                                    cubitP.switched(index);
                                    cubitP.updatePackagesStatus(
                                      indexs: index,
                                      packagesRequest: PackagesRequest(
                                        id: cubitP.packageList[index].id,
                                        active: cubitP
                                                .packageList[index].active.isOdd
                                            ? 1
                                            : 0,
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 1.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      cubit.isedit = true;
                                      nameEn.text =
                                          cubitP.packageList[index].nameEn;
                                      descriptionEn.text = cubitP
                                          .packageList[index].descriptionEn;
                                      nameAr.text =
                                          cubitP.packageList[index].nameAr;
                                      descriptionAr.text = cubitP
                                          .packageList[index].descriptionAr;
                                      price.text = cubitP
                                          .packageList[index].price
                                          .toString();
                                      dropItemsItem =
                                          cubitP.packageList[index].type;
                                      imageApp =
                                          cubitP.packageList[index].image;
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
                                                const DefaultText(
                                                    text: "Update Package",
                                                    align: TextAlign.center),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: nameAr.text,
                                                    password: false,
                                                    controller: nameAr,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: 'Arabic Name',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: nameEn.text,
                                                    password: false,
                                                    controller: nameEn,
                                                    height: 5.h,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: 'English Name',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: SizedBox(
                                                    height: 20.h,
                                                    child: DefaultTextField(
                                                      validator:
                                                          descriptionAr.text,
                                                      password: false,
                                                      controller: descriptionAr,
                                                      height: 20.h,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      fontSize: 3.sp,
                                                      haveShadow: true,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      maxLine: 7,
                                                      collapsed: true,
                                                      color: AppColors.white,
                                                      shadowColor: AppColors
                                                          .black
                                                          .withOpacity(0.05),
                                                      hintText:
                                                          'Arabic Description',
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator:
                                                        descriptionEn.text,
                                                    password: false,
                                                    controller: descriptionEn,
                                                    height: 20.h,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    fontSize: 3.sp,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    maxLine: 7,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText:
                                                        'English Description',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child: DefaultTextField(
                                                    validator: price.text,
                                                    password: false,
                                                    height: 7.h,
                                                    fontSize: 4.sp,
                                                    controller: price,
                                                    haveShadow: true,
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    color: AppColors.white,
                                                    shadowColor: AppColors.black
                                                        .withOpacity(0.05),
                                                    hintText: 'Price',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 2.h,
                                                      left: 3.w,
                                                      right: 3.w),
                                                  child:
                                                      DefaultDropdown<String>(
                                                    hint: "Category",
                                                    showSearchBox: true,
                                                    selectedItem:
                                                        dropItemsItem == ''
                                                            ? cubitP
                                                                .categoryTypes
                                                                .last
                                                            : dropItemsItem,
                                                    items: cubitP.categoryTypes,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        dropItemsItem = val!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.h,
                                                        left: 3.w,
                                                        right: 3.w),
                                                    child: BlocBuilder<
                                                        PackagesCubit,
                                                        PackagesState>(
                                                      builder:
                                                          (context, state) {
                                                        return Container(
                                                          height: 20.h,
                                                          width: 20.w,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: cubit.isedit
                                                              ? Stack(
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20),
                                                                        child: imageApp ==
                                                                                null
                                                                            ? cubitP.fileResult == null
                                                                                ? Container()
                                                                                : Image.memory(
                                                                                    cubitP.fileResult!.files.first.bytes!,
                                                                                    fit: BoxFit.fitWidth,
                                                                                    width: 100.w,
                                                                                  )
                                                                            : Image.network(
                                                                                imageDomain + imageApp!,
                                                                                fit: BoxFit.fitWidth,
                                                                                width: 100.w,
                                                                              )),
                                                                    Container(
                                                                      height:
                                                                          4.h,
                                                                      width:
                                                                          3.w,
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20),
                                                                              bottomRight: Radius.circular(20)),
                                                                          color: AppColors.green),
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            cubitP.pickImage();
                                                                            imageApp =
                                                                                null;
                                                                            printSuccess(cubitP.fileResult.toString());
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.edit,
                                                                            color:
                                                                                AppColors.white,
                                                                          )),
                                                                    )
                                                                  ],
                                                                )
                                                              : cubitP.fileResult ==
                                                                      null
                                                                  ? Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.image),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              cubitP.pickImage();
                                                                            },
                                                                            child:
                                                                                const Text('Select Image'))
                                                                      ],
                                                                    )
                                                                  : Stack(
                                                                      children: [
                                                                        ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            child: Image.memory(
                                                                              cubitP.fileResult!.files.first.bytes!,
                                                                              fit: BoxFit.fitWidth,
                                                                              width: 100.w,
                                                                            )),
                                                                        Container(
                                                                          height:
                                                                              4.h,
                                                                          width:
                                                                              3.w,
                                                                          decoration: const BoxDecoration(
                                                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                                                                              color: AppColors.green),
                                                                          child: IconButton(
                                                                              onPressed: () {
                                                                                cubitP.pickImage();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.edit,
                                                                                color: AppColors.white,
                                                                              )),
                                                                        )
                                                                      ],
                                                                    ),
                                                        );
                                                      },
                                                    )),
                                              ],
                                            ),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          actions: <Widget>[
                                            DefaultAppButton(
                                              title: "Save",
                                              onTap: () {
                                                cubitP.updatePackages(
                                                  index: index,
                                                  packagesRequest:
                                                      PackagesRequest(
                                                    id: cubitP
                                                        .packageList[index].id,
                                                    nameEn: nameEn.text,
                                                    descriptionEn:
                                                        descriptionEn.text,
                                                    nameAr: nameAr.text,
                                                    descriptionAr:
                                                        descriptionAr.text,
                                                    price: double.parse(
                                                        price.text),
                                                    type: dropItemsItem == ''
                                                        ? cubitP
                                                            .categoryTypes.last
                                                        : dropItemsItem,
                                                  ),
                                                );
                                                nameEn.clear();
                                                descriptionEn.clear();
                                                nameAr.clear();
                                                descriptionAr.clear();
                                                price.clear();
                                                cubitP.fileResult = null;
                                                dropItemsItem = '';
                                                Navigator.pop(context);
                                              },
                                              width: 10.w,
                                              height: 4.h,
                                              fontSize: 3.sp,
                                              textColor: AppColors.white,
                                              buttonColor: AppColors.pc,
                                              isGradient: false,
                                              radius: 10,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            DefaultAppButton(
                                              title: "Cancel",
                                              onTap: () {
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
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.grey,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AddItems(
                                          packageId:
                                              cubitP.packageList[index].id,
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.grey,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    PackagesCubit.get(context).getPackageInfo(
                                      id: cubitP.packageList[index].id,
                                      afterSuccess: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ViewItems(
                                              items: PackagesCubit.get(context)
                                                      .packageDetailsResponse!
                                                      .items ??
                                                  [],
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    color: AppColors.grey,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubitP.deletePackages(
                                        packagesModel:
                                            cubitP.packageList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColors.red,
                                  )),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
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
