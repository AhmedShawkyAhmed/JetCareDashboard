import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/corporate/data/models/corporate_order_model.dart';
import 'package:jetboard/src/features/corporate/data/requests/corporate_order_request.dart';
import 'package:retrofit/retrofit.dart';

part 'corporate_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class CorporateWebService {
  factory CorporateWebService(Dio dio, {String baseUrl}) = _CorporateWebService;

  @GET(EndPoints.getCorporateOrders)
  Future<NetworkBaseModel<List<CorporateOrderModel>>> getCorporateOrders({
    @Query("keyword") String? keyword,
  });

  @POST(EndPoints.addCorporateOrder)
  Future<NetworkBaseModel<CorporateOrderModel>> addCorporateOrder({
    @Body() required CorporateOrderRequest request,
  });

  @POST(EndPoints.corporateAdminComment)
  Future<NetworkBaseModel> corporateAdminComment({
    @Field("id") required int id,
    @Field("admin_comment") required String adminComment,
  });

  @POST(EndPoints.contactCorporate)
  Future<NetworkBaseModel> contactCorporate({
    @Query("id") required int id,
  });
}
