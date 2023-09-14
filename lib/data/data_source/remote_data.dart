import 'package:mina_farid/data/network/app_api.dart';
import 'package:mina_farid/data/network/requests.dart';

import '../response/responses.dart';

abstract class RemoteDataSource {
  // login
  Future<LoginResponse> login(LoginRequest loginRequest);

  // forgotPassword
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);

  // register
  Future<LoginResponse> register(RegisterRequest request);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    return await _appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<LoginResponse> register(RegisterRequest request) async {
    return await _appServiceClient.register(
        request.userName, request.countryCode, request.mobileNumber,
        request.email, request.password, request.photo);
  }
}
