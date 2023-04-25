import 'package:fluttertoast/fluttertoast.dart';
import 'package:jetboard/src/presentation/styles/app_colors.dart';

class DefaultToast {
  static Future<bool?> showMyToast(String msg,{bool? isError,Toast? toastLength})async{
    return await Fluttertoast.showToast(
      msg: msg,
      toastLength:Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.white,
      textColor: AppColors.white,
      fontSize: 14.0,
    );
  }
}
