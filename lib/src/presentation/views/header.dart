import 'package:flutter/material.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:jetboard/src/presentation/widgets/default_text_field.dart';
import 'package:sizer/sizer.dart';

class Header extends StatefulWidget {
  Header({
    Key? key,
    required this.search,
    required this.haveExport,
    required this.haveAdd,
    this.add,
    this.heightSearch,
    this.widthSearch,
    this.fontSearch,
    this.heightAdd,
    this.widthAdd,
    this.fontAdd,
    this.heightExport,
    this.widthExport,
    this.fontExport,
    this.menuButton,
    this.haveDrawer,
    this.hintText,
    this.dropList,
    this.list,
    this.value,

  }) : super(key: key);

  final TextEditingController search;
  bool haveExport = false;
  bool haveAdd = false;
  String? hintText;
  VoidCallback? add;
  double? heightSearch, widthSearch, fontSearch;
  double? heightExport, widthExport, fontExport;
  double? heightAdd, widthAdd, fontAdd;
  VoidCallback? menuButton;
  bool? haveDrawer;
  Widget? dropList;
  List<String>? list;
  String? value;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String dropdownvalue = 'Item 1'; 
  var value1 = [    
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.haveDrawer! ? IconButton(
          onPressed: widget.menuButton,
          icon: const Icon(Icons.menu),
        ):const SizedBox(),
        DefaultTextField(
          password: false,
          width: widget.widthSearch ?? 25.w,
          height: widget.heightSearch ?? 5.h,
          fontSize: widget.fontSearch ?? 4.sp,
          color: AppColors.white,
          bottom: 0.5.h,
          hintText: widget.hintText,
          spreadRadius: 2,
          blurRadius: 2,
          shadowColor: AppColors.black.withOpacity(0.05),
          haveShadow: true,
          controller: widget.search,
          suffix:  IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
            color: AppColors.black,
          ),
        ),
        
        // DropdownButton(
        //       value: widget.value,
        //       icon: const Icon(Icons.keyboard_arrow_down),    
        //       items:  widget.list!.map<DropdownMenuItem<String>>((value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //       onChanged: (String? newValue) { 
        //         setState(() {
        //           dropdownvalue = newValue!;
        //         });
        //       },
        //     ),
        // const Spacer(),
        // widget.haveExport
        //     ? DefaultAppButton(
        //         width: widget.widthExport ?? 8.w,
        //         height: widget.heightExport ?? 5.h,
        //         radius: 10,
        //         isGradient: false,
        //         haveShadow: true,
        //         spreadRadius: 2,
        //         blurRadius: 2,
        //         offset: const Offset(0, 0),
        //         buttonColor: AppColors.black,
        //         fontSize: widget.fontExport ?? 5.sp,
        //         title: "Export",
        //         onTap: () {},
        //       )
        //     : const SizedBox(),
        // SizedBox(
        //   width: 2.w,
        // ),
        // widget.haveAdd ?
        // DefaultAppButton(
        //   width: widget.widthAdd ?? 8.w,
        //   height: widget.heightAdd ?? 5.h,
        //   haveShadow: true,
        //   offset: const Offset(0, 0),
        //   spreadRadius: 2,
        //   blurRadius: 2,
        //   radius: 10,
        //   gradientColors: const [
        //     AppColors.green,
        //     AppColors.lightgreen,
        //   ],
        //   fontSize: widget.fontAdd ?? 5.sp,
        //   title: "Add",
        //   onTap: widget.add!,
        // ):const SizedBox(),
      ],
    );
  }
}
