import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/orders/data/models/order_model.dart';
import 'package:jetboard/src/features/orders/data/requests/cart_request.dart';
import 'package:jetboard/src/features/orders/data/requests/order_request.dart';
import 'package:retrofit/retrofit.dart';

part 'orders_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class OrdersWebService {
  factory OrdersWebService(Dio dio, {String baseUrl}) = _OrdersWebService;

  @GET(EndPoints.getOrders)
  Future<NetworkBaseModel<List<OrderModel>>> getOrders({
    @Query("keyword") String? keyword,
    @Query("status") String? status,
});

  @POST(EndPoints.createOrder)
  Future<NetworkBaseModel> createOrder({
    @Body() required OrderRequest request,
  });

  @POST(EndPoints.updateOrderStatus)
  Future<NetworkBaseModel> updateOrderStatus({
    @Field("id") required int id,
    @Field("status") required OrderStatus status,
    @Field("reason") String? reason,
  });

  @POST(EndPoints.updateAdminComment)
  Future<NetworkBaseModel> updateAdminComment({
    @Field("order_id") required int orderId,
    @Field("admin_comment") required String adminComment,
  });

  @POST(EndPoints.assignOrder)
  Future<NetworkBaseModel> assignOrder({
    @Field("order_id") required int orderId,
    @Field("crew_id") required int crewId,
    @Field("date") required String date,
  });

  @POST(EndPoints.addExtraFees)
  Future<NetworkBaseModel> addExtraFees({
    @Field("order_id") required int orderId,
    @Field("extra_fees") required double extraFees,
  });

  @POST(EndPoints.addToCart)
  Future<NetworkBaseModel> addToCart({
    @Body() required CartRequest request,
  });

  @DELETE(EndPoints.deleteOrder)
  Future<NetworkBaseModel> deleteOrder({
    @Query("id") required int id,
  });
}
