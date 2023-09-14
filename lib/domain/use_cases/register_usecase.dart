import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/network/requests.dart';

import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCass<RegisterUseCaseInput, LoginModel> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.userName,
        input.countryCode, input.mobileNumber, input.email, input.password,input.photo));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String photo;

  RegisterUseCaseInput(this.userName, this.countryCode, this.mobileNumber,
      this.email, this.password, this.photo);
}
