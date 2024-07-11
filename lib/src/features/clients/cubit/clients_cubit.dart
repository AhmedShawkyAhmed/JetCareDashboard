import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/shared/models/user_model.dart';
import 'package:jetboard/src/core/shared/requests/register_request.dart';
import 'package:jetboard/src/core/shared/views/indicator_view.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';
import 'package:jetboard/src/features/areas/data/models/area_model.dart';
import 'package:jetboard/src/features/clients/data/models/address_model.dart';
import 'package:jetboard/src/features/clients/data/repo/clients_repo.dart';
import 'package:jetboard/src/features/clients/data/requests/address_request.dart';
import 'package:jetboard/src/features/orders/cubit/orders_cubit.dart';
import 'package:jetboard/src/features/orders/data/requests/cart_request.dart';
import 'package:jetboard/src/features/orders/data/requests/order_request.dart';

part 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  ClientsCubit(this.repo) : super(ClientsInitial());
  final ClientsRepo repo;

  List<UserModel>? clients;
  List<AddressModel> address = [];
  List<AreaModel> states = [];
  List<AreaModel> areas = [];

  bool pass = true;

  void isPassword() {
    pass = !pass;
  }

  Future switched(UserModel client) async {
    if (client.isActive!) {
      await stopAccount(userId: client.id!);
    } else {
      await activateAccount(userId: client.id!);
    }
    emit(PickedSwitchState());
  }

  Future getClients({
    String? keyword,
  }) async {
    emit(GetClientsLoading());
    var response = await repo.getClients(
      keyword: keyword,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        clients = response.data;
        emit(GetClientsSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetClientsFailure());
        error.showError();
      },
    );
  }

  Future addClient({
    required RegisterRequest request,
  }) async {
    if (request.name == "") {
      DefaultToast.showMyToast("Please Enter the Full Name");
      return;
    } else if (request.phone == "" || request.phone.length < 11) {
      DefaultToast.showMyToast("Please Enter Correct Phone Number");
      return;
    } else if (request.email == "") {
      DefaultToast.showMyToast("Please Enter Correct Email Address");
      return;
    } else if (request.password == "" || request.password.length < 8) {
      DefaultToast.showMyToast("Please Enter Password more than 8 Characters");
      return;
    }
    IndicatorView.showIndicator();
    emit(AddClientLoading());
    var response = await repo.addClient(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddClientSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddClientFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future addClientForOrder({
    required RegisterRequest request,
    required AddressRequest addressRequest,
    required bool isNewClient,
    required OrdersCubit ordersCubit,
    required CartRequest cartRequest,
    required OrderRequest orderRequest,
  }) async {
    if (isNewClient) {
      if (request.name == "") {
        DefaultToast.showMyToast("Please Enter the Full Name");
        return;
      } else if (request.phone == "" || request.phone.length < 11) {
        DefaultToast.showMyToast("Please Enter Correct Phone Number");
        return;
      } else if (request.email == "") {
        DefaultToast.showMyToast("Please Enter Correct Email Address");
        return;
      } else if (request.password == "" || request.password.length < 8) {
        DefaultToast.showMyToast(
            "Please Enter Password more than 8 Characters");
        return;
      }
      IndicatorView.showIndicator();
      emit(AddClientLoading());
      var response = await repo.addClient(
        request: request,
      );
      response.when(
        success: (NetworkBaseModel response) async {
          await addAddress(
            request: AddressRequest(
              userId: response.data.id!,
              stateId: addressRequest.stateId,
              areaId: addressRequest.areaId,
              address: addressRequest.address,
              phone: addressRequest.phone,
              latitude: addressRequest.latitude,
              longitude: addressRequest.longitude,
            ),
          );
          emit(AddClientSuccess());
          await ordersCubit.createOrderForUser(
            request: cartRequest,
            orderRequest: orderRequest,
          );
        },
        failure: (NetworkExceptions error) {
          emit(AddClientFailure());
          NavigationService.pop();
          error.showError();
        },
      );
    } else {
      await ordersCubit.createOrderForUser(
        request: cartRequest,
        orderRequest: orderRequest,
      );
    }
  }

  Future updateClient({
    required UserModel request,
  }) async {
    IndicatorView.showIndicator();
    emit(UpdateClientLoading());
    var response = await repo.updateClient(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UpdateClientSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(UpdateClientFailure());
        NavigationService.pop();
        error.showError();
      },
    );
  }

  Future activateAccount({
    required int userId,
  }) async {
    emit(ActivateAccountLoading());
    var response = await repo.activateAccount(
      userId: userId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (clients != null) {
          clients!.firstWhere((item) => item.id == userId).isActive = true;
        }
        emit(ActivateAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(ActivateAccountFailure());
        error.showError();
      },
    );
  }

  Future stopAccount({
    required int userId,
  }) async {
    emit(StopAccountLoading());
    var response = await repo.stopAccount(
      userId: userId,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (clients != null) {
          clients!.firstWhere((item) => item.id == userId).isActive = false;
        }
        emit(StopAccountSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(StopAccountFailure());
        error.showError();
      },
    );
  }

  Future userAdminComment({
    required int userId,
    required String adminComment,
    required VoidCallback afterSuccess,
  }) async {
    emit(UserAdminCommentLoading());
    var response = await repo.userAdminComment(
      userId: userId,
      adminComment: adminComment,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UserAdminCommentSuccess());
        afterSuccess();
      },
      failure: (NetworkExceptions error) {
        emit(UserAdminCommentFailure());
        error.showError();
      },
    );
  }

  Future deleteClient({
    required int id,
  }) async {
    emit(DeleteClientLoading());
    var response = await repo.deleteClient(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(DeleteClientSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteClientFailure());
        error.showError();
      },
    );
  }

  Future getMyAddresses({
    required int clientId,
  }) async {
    address.clear();
    emit(GetMyAddressesLoading());
    var response = await repo.getMyAddresses(clientId: clientId);
    response.when(
      success: (NetworkBaseModel response) async {
        address = response.data;
        emit(GetMyAddressesSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetMyAddressesFailure());
      },
    );
  }

  Future addAddress({
    required AddressRequest request,
  }) async {
    if (request.phone == null || request.phone == "") {
      DefaultToast.showMyToast("Enter Phone Number");
      return;
    } else if (request.address == null || request.address == "") {
      DefaultToast.showMyToast("Enter Address");
      return;
    } else if (request.stateId == null || request.stateId == 0) {
      DefaultToast.showMyToast("Select State");
      return;
    } else if (request.areaId == null || request.areaId == 0) {
      DefaultToast.showMyToast("Select Area");
      return;
    }
    IndicatorView.showIndicator();
    emit(AddAddressLoading());
    var response = await repo.addAddress(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        NavigationService.pop();
        getMyAddresses(clientId: request.userId);
        NavigationService.pop();
        emit(AddAddressSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(AddAddressFailure());
      },
    );
  }

  Future getStates() async {
    states.clear();
    emit(GetStatesLoading());
    var response = await repo.getStates();
    response.when(
      success: (NetworkBaseModel response) async {
        states = response.data;
        emit(GetStatesSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetStatesFailure());
      },
    );
  }

  Future getAreasOfState({
    required int stateId,
  }) async {
    areas.clear();
    emit(GetAreasLoading());
    var response = await repo.getAreasOfState(stateId: stateId);
    response.when(
      success: (NetworkBaseModel response) async {
        areas = response.data;
        emit(GetAreasSuccess());
      },
      failure: (NetworkExceptions error) {
        error.showError();
        emit(GetAreasFailure());
      },
    );
  }
}
