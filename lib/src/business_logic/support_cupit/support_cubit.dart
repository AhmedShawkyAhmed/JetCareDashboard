import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/models/support_model.dart';
import 'package:jetboard/src/data/network/requests/support_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/support_response.dart';

import '../../presentation/widgets/toast.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportCupitInitial());

  static SupportCubit get(context) => BlocProvider.of(context);
  SupportResponse? supportResponse, deleteSupportResponse, updateSupportResponse;
  GlobalResponse? globalResponse;
  List<SupportModel> supportList = [];
  int listCount = 0;
  int index = 0;
  


  Future getSupport({String? keyword}) async {
    supportList.clear();
    listCount= 0;
    try {
      emit(SupportLodingState());
      await DioHelper.getData(
        url: EndPoints.getSupport,
        query: {
          "keyword" : keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        supportResponse = SupportResponse.fromJson(myData);
        supportList.addAll(supportResponse!.supportModel!);  
        listCount = supportResponse!.supportModel!.length;
        emit(SupportSuccessState());
        printResponse(value.data.toString());
      });
    } on DioError catch (n) {
      emit(SupportErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(SupportErrorState());
      printResponse(e.toString());
    }
  }

  Future deleteSupport({
   required SupportModel supportModel
  }) async {
    try {
      emit(DeleteLodingState());
      await DioHelper.postData(
        url: EndPoints.deleteSupport,
        body: {
          'id': supportModel.id,
        },
        ).then((value) {
          final myData = Map<String, dynamic>.from(value.data);
          deleteSupportResponse = SupportResponse.fromJson(myData);
          supportList.remove(supportModel);
          listCount -=1;
          emit(DeleteSuccessState());
         DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(DeleteErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(DeleteErrorState());
      printResponse(e.toString());
    }
  }

  Future updateSupport({
   required SupportRequest supportRequest,
   //required int indexs,
  }) async {
    try {
      emit(ChangeSupportLodingState());
      await DioHelper.postData(
        url: EndPoints.changeSupportStatus,
        body: {
          'id':supportRequest.id,
          'active': supportRequest.active,
        },
        ).then((value) {
          final myData = Map<String, dynamic>.from(value.data);
          updateSupportResponse = SupportResponse.fromJson(myData);
          supportList[index] = supportResponse!.supportModel![index];        
          emit(ChangeSupportSuccessState());
          //printResponse(supportList);
          DefaultToast.showMyToast(value.data['message']);
        });
    } on DioError catch (n) {
      emit(ChangeSupportErrorState());
      printResponse(n.toString());
    } catch (e) {
      emit(ChangeSupportErrorState());
      printResponse(e.toString());
    }
  }


  Future corporateAdminComment({
    required int orderId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(CommentSupportLoadingState());
      await DioHelper.postData(url: EndPoints.supportComment, body: {
        'id': orderId,
        'comment':comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        printSuccess(
            "Update Corporate Comment Response ${globalResponse!.message.toString()}");
        emit(CommentSupportSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CommentSupportErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CommentSupportErrorState());
      printError(e.toString());
    }
  }
}
