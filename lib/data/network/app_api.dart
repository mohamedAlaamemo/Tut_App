import 'package:dio/dio.dart';
import 'package:mina_farid/presentation/resources/constants_manager.dart';
import 'package:retrofit/http.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<LoginResponse> login(
      @Field('email') String email, @Field('password') String password);

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field('email') String email);

  @POST("/customers/register")
  Future<LoginResponse> register(
    @Field('userName') String userName,
    @Field('countryCode') String countryCode,
    @Field('mobileNumber') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('photo') String photo,
  );
}
