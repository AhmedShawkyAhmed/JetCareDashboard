import 'package:dio/dio.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/features/support/data/models/support_model.dart';
import 'package:jetboard/src/features/support/data/requests/support_comment_request.dart';
import 'package:retrofit/retrofit.dart';

part 'support_web_service.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SupportWebService {
  factory SupportWebService(Dio dio, {String baseUrl}) = _SupportWebService;

  @POST(EndPoints.supportComment)
  Future<NetworkBaseModel> supportComment({
    @Body() required SupportCommentRequest request,
  });

  @GET(EndPoints.getSupport)
  Future<NetworkBaseModel<List<SupportModel>>> getSupport({
    @Query("keyword") String? keyword,
  });

  @DELETE(EndPoints.deleteSupport)
  Future<NetworkBaseModel> deleteSupport({
    @Query("id") required int id,
  });
}
