import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/models/corporates_model.dart';
import '../../data/network/responses/corporates_response.dart';
import 'package:flutter/material.dart';
part 'corporates_state.dart';

class CorporatesCubit extends Cubit<CorporatesState> {
  CorporatesCubit() : super(CorporatesInitial());
  static CorporatesCubit get(context) => BlocProvider.of(context);
  CorporatesResponse? getCorporatesResponse;
  GlobalResponse? globalResponse;
  List<CorporatesModel> corporatesList = [];
  int listCount = 0;
  int index = 0;

  Future getCorporates({
    String? keyword,
  }) async {
    corporatesList.clear();
    listCount = 0;
    try {
      emit(CorporatesLoadingState());
      await DioHelper.getData(
        url: EndPoints.getCorporateOrders,
        query: {
          "keyword": keyword,
        },
      ).then((value) {
        final myData = Map<String, dynamic>.from(value.data);
        getCorporatesResponse = CorporatesResponse.fromJson(myData);
        corporatesList.addAll(getCorporatesResponse!.corporatesModel!);
        listCount = getCorporatesResponse!.corporatesModel!.length;
        emit(CorporatesSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(CorporatesErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CorporatesErrorState());
      printError(e.toString());
    }
  }

  Future corporateAdminComment({
    required int orderId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateCorporateStatusLoadingState());
      await DioHelper.postData(url: EndPoints.corporateAdminComment, body: {
        'id': orderId,
        'comment':comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        printSuccess(
            "Update Corporate Comment Response ${globalResponse!.message.toString()}");
        emit(UpdateCorporateStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(UpdateCorporateStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateCorporateStatusErrorState());
      printError(e.toString());
    }
  }
}
