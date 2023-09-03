import 'package:dio/dio.dart';
import 'package:mina_farid/presentation/resources/constants_manager.dart';
import 'package:retrofit/http.dart';
import '../response/responses.dart';
part 'app_api.g.dart';


@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {

  factory AppServiceClient(Dio dio, {required String baseUrl})=_AppServiceClient;

  @POST("/customers/login")
  Future<LoginResponse> login(
      @Field('email') String email, @Field('password') String password);
}
