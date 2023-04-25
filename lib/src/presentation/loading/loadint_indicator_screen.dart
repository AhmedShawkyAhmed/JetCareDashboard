import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 10.w,
        height: 10.w,
        child: const CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
  }
}
