import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/network/failure.dart';
import 'package:mina_farid/domain/model/model.dart';
import 'package:mina_farid/domain/repository/repository.dart';
import 'package:mina_farid/domain/use_cases/base_usecase.dart';

import '../../data/network/requests.dart';

class LoginUseCase implements BaseUseCass<LoginUseCaseInput, LoginModel> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
