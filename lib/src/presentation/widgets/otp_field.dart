import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';
import 'package:sizer/sizer.dart';

class OTPField extends StatefulWidget {
  final String? otp1, otp2, otp3, otp4;

  const OTPField({
    this.otp1,
    this.otp2,
    this.otp3,
    this.otp4,
    Key? key,
  }) : super(key: key);

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  bool fromLeft = true;
  int active = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: active == 1?AppColors.lightGrey.withOpacity(0.4):AppColors.midGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.6),
              ),
            ),
            child: Center(
              child: TextFormField(
                cursorColor: AppColors.lightGrey,
                onSaved: (pin2) {},
                onChanged: (value) {
                 // codeController.text = codeController.text + value;
                  if (fromLeft) {
                    FocusScope.of(context).nextFocus();
                    setState(() {
                      active = 2;
                      fromLeft = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.otp4,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                obscureText: true,
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: active == 2?AppColors.lightGrey.withOpacity(0.4):AppColors.midGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.6),
              ),
            ),
            child: Center(
              child: TextFormField(
                cursorColor: AppColors.lightGrey,
                onSaved: (pin2) {},
                onChanged: (value) {
                  //codeController.text = codeController.text + value;
                  if (fromLeft) {
                    FocusScope.of(context).previousFocus();
                    setState(() {
                      active = 1;
                      fromLeft = false;
                    });
                  } else {
                    setState((){
                      active = 3;
                    });
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.otp3,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                obscureText: true,
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: active == 3?AppColors.lightGrey.withOpacity(0.4):AppColors.midGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.6),
              ),
            ),
            child: Center(
              child: TextFormField(
                cursorColor: AppColors.lightGrey,
                onSaved: (pin2) {},
                onChanged: (value) {
                  //codeController.text = codeController.text + value;
                  if (fromLeft) {
                    setState((){
                      active = 2;
                    });
                    FocusScope.of(context).previousFocus();
                  } else {
                    setState((){
                      active = 4;
                    });
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                  hintText: widget.otp2,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                obscureText: true,
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: active == 4?AppColors.lightGrey.withOpacity(0.4):AppColors.midGrey,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.darkGrey.withOpacity(0.6),
              ),
            ),
            child: Center(
              child: TextFormField(
                cursorColor: AppColors.lightGrey,
                onSaved: (pin2) {},
                onChanged: (value) {
                  //codeController.text = codeController.text + value;
                  if (fromLeft) {
                    setState((){
                      active = 3;
                    });
                    FocusScope.of(context).previousFocus();
                  }
                  setState(() {
                    fromLeft = true;
                  });
                },
                decoration: InputDecoration(
                  hintText: widget.otp1,
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                obscureText: true,
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
