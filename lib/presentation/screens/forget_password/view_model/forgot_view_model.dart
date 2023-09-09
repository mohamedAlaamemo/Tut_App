import 'dart:async';

import 'package:mina_farid/domain/use_cases/forgot_usecace.dart';
import 'package:mina_farid/presentation/base/base_view_model.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _streamController =
      StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  late String _emailUserInput = "";

  @override
  void start() {}

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  setEmail(String email) {
    emailInput.add(email);
    _emailUserInput = email;
    print('+++++++++++$_emailUserInput');
  }

  @override
  resetPassword() async {
    (await _forgotPasswordUseCase
            .execute(ForgotPasswordUseCaseInput(_emailUserInput)))
        .fold((failure) {

    }, (data) {

    });
  }

  @override
  Sink get emailInput => _streamController.sink;

  @override
  Stream<bool> get emailValid =>
      _streamController.stream.map((email) => isEmailValid(email));

  bool isEmailValid(String email) {
    var bool = (email.length > 5) ? true : false;
    return bool;
  }
}

abstract class ForgotPasswordViewModelInput {
  setEmail(String email);

  resetPassword();

  Sink get emailInput;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get emailValid;
}
