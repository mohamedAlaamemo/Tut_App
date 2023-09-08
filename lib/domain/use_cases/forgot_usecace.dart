import 'package:dartz/dartz.dart';
import 'package:mina_farid/data/network/failure.dart';
import 'package:mina_farid/data/network/requests.dart';
import 'package:mina_farid/domain/model/model.dart';
import 'package:mina_farid/domain/repository/repository.dart';
import 'package:mina_farid/domain/use_cases/base_usecase.dart';

class ForgotPasswordUseCase
    implements BaseUseCass<ForgotPasswordUseCaseInput, ForgotPasswordModel> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordModel>> execute(
      ForgotPasswordUseCaseInput input) async {
    return await _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }
}

class ForgotPasswordUseCaseInput {
  String email;

  ForgotPasswordUseCaseInput(this.email);
}
