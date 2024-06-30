import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/corporate/data/models/corporate_order_model.dart';
import 'package:jetboard/src/features/corporate/data/repo/corporate_repo.dart';
import 'package:jetboard/src/features/corporate/data/requests/corporate_order_request.dart';

part 'corporate_state.dart';

class CorporateCubit extends Cubit<CorporateState> {
  CorporateCubit(this.repo) : super(CorporateInitial());
  final CorporateRepo repo;

  List<CorporateOrderModel>? corporateOrders;

  Future getCorporateOrders({
    String? keyword,
  }) async {
    emit(GetCorporateOrdersLoading());
    var response = await repo.getCorporateOrders(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        corporateOrders = response.data;
        emit(GetCorporateOrdersSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetCorporateOrdersFailure());
        error.showError();
      },
    );
  }

  Future addCorporateOrder({
    required CorporateOrderRequest request,
  }) async {
    if (request.name == "") {
      DefaultToast.showMyToast("Please Enter Corporate Name");
      return;
    } else if (request.phone == "") {
      DefaultToast.showMyToast("Please Enter Phone Number");
      return;
    } else if (request.email == "") {
      DefaultToast.showMyToast("Please Enter Email Address");
      return;
    } else if (request.message == "") {
      DefaultToast.showMyToast("Please Enter Description Message");
      return;
    } else if (request.itemId == 0) {
      DefaultToast.showMyToast("Please Select Service");
      return;
    }
    IndicatorView.showIndicator();
    emit(AddCorporateOrderLoading());
    var response = await repo.addCorporateOrder(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddCorporateOrderSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddCorporateOrderFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future corporateAdminComment({
    required int id,
    required String adminComment,
    required VoidCallback afterSuccess,
  }) async {
    emit(AdminCommentLoading());
    var response = await repo.corporateAdminComment(
      id: id,
      adminComment: adminComment,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AdminCommentSuccess());
        afterSuccess();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AdminCommentFailure());
        error.showError();
      },
    );
  }

  Future contactCorporate({
    required int id,
  }) async {
    emit(ContactCorporateLoading());
    var response = await repo.contactCorporate(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(ContactCorporateSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ContactCorporateFailure());
        error.showError();
      },
    );
  }
}
