import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/requests/address_request.dart';
import 'package:jetboard/src/data/network/responses/address_response.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  static AddressCubit get(context) => BlocProvider.of(context);

  AddressResponse? addressResponse, addAddressResponse;
  GlobalResponse? globalResponse, deleteResponse;
  List<String> address = [];

  Future getMyAddresses({
    required int userId,
    required VoidCallback afterSuccess,
  }) async {
    address.clear();
    try {
      emit(AddressLoadingState());
      await DioHelper.getData(url: EndPoints.getMyAddresses, query: {
        "userId": userId,
      }).then((value) {
        addressResponse = AddressResponse.fromJson(value.data);
        printSuccess("Address Response ${addressResponse!.message.toString()}");
        if(addressResponse?.address != null){
          for (int i = 0; i < addressResponse!.address!.length; i++) {
            address.add(
                "${addressResponse!.address![i].address},${addressResponse!.address![i].area!.nameAr},${addressResponse!.address![i].state!.nameAr}");
          }
        }
        emit(AddressSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddressErrorState());
      printError(e.toString());
    }
  }

  Future addAddress({
    required AddressRequest addressRequest,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AddAddressLoadingState());
      await DioHelper.postData(url: EndPoints.addAddress, body: {
        'userId': addressRequest.userId,
        'phone': addressRequest.phone,
        'address': addressRequest.address,
        'stateId': addressRequest.stateId,
        'areaId': addressRequest.areaId,
        'latitude': "0.0",
        'longitude': "0.0",
      }).then((value) {
        addAddressResponse = AddressResponse.fromJson(value.data);
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddAddressErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddAddressErrorState());
      printError(e.toString());
    }
  }

// Future updateAddress({
//   required AddressRequest addressRequest,
//   required VoidCallback afterSuccess,
// }) async {
//   try {
//     emit(EditAddressLoadingState());
//     await DioHelper.postData(url: EndPoints.updateAddress, body: {
//       'id': addressRequest.userId,
//       'phone': addressRequest.phone,
//       'floor': addressRequest.floor,
//       'building': addressRequest.building,
//       'street': addressRequest.street,
//       'area': addressRequest.area,
//       'district': addressRequest.district,
//       'latitude': addressRequest.latitude,
//       'longitude': addressRequest.longitude,
//     }).then((value) {
//       addAddressResponse = AddressResponse.fromJson(value.data);
//       printSuccess(
//           "Edit Address Response ${addAddressResponse!.message.toString()}");
//       afterSuccess();
//     });
//   } on DioError catch (n) {
//     emit(EditAddressErrorState());
//     printError(n.toString());
//   } catch (e) {
//     emit(EditAddressErrorState());
//     printError(e.toString());
//   }
// }

// Future deleteAddress({
//   required AddressModel address,
// }) async {
//   try {
//     emit(DeleteAddressLoadingState());
//     await DioHelper.postData(url: EndPoints.deleteAddress, body: {
//       'id': address.id,
//     }).then((value) {
//       printResponse(value.data.toString());
//       deleteResponse = GlobalResponse.fromJson(value.data);
//       printSuccess(
//           "Delete Address Response ${deleteResponse!.message.toString()}");
//       addressList.remove(address);
//       addressCount -= 1;
//       emit(DeleteAddressSuccessState());
//     });
//   } on DioError catch (n) {
//     emit(DeleteAddressErrorState());
//     printError(n.toString());
//   } catch (e) {
//     emit(DeleteAddressErrorState());
//     printError(e.toString());
//   }
// }
}
