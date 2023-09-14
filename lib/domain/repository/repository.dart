import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/network/requests.dart';
import 'package:mina_farid/domain/model/model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, LoginModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<Either<Failure, LoginModel>> register(RegisterRequest registerRequest);
}
