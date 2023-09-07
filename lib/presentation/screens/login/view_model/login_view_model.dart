import 'dart:async';

import 'package:mina_farid/presentation/base/base_view_model.dart';

import '../../../../domain/use_cases/login_usecase.dart';
import '../../../common/freezed_data.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _checkDataStreamController =
      StreamController<void>.broadcast();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  var loginObject = LoginObject("", "");

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _checkDataStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  setUserName(String userName) {
    userNameInput.add(userName);
    loginObject = loginObject.copyWith(email: userName);

    userNameInput.add(userName);
    allDataValidInput.add(null);
  }

  @override
  setPassword(String password) {
    passwordInput.add(password);
    loginObject = loginObject.copyWith(password: password);
    userNameInput.add(password);
    allDataValidInput.add(null);
  }

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.email, loginObject.password)))
        .fold((failure) {}, (data) {});
  }

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  @override
  Sink get allDataValidInput => _checkDataStreamController.sink;

  @override
  Stream<bool> get passwordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get userNameValid => _userNameStreamController.stream
      .map((userName) => isUserNameValid(userName));

  @override
  Stream<bool> get allDataValid =>
      _checkDataStreamController.stream.map((_) => isAllDataValid());

  bool isPasswordValid(String password) {
    var bool = (password.length > 5) ? true : false;
    return bool;
  }

  bool isUserNameValid(String userName) {
    var bool = (userName.length > 5) ? true : false;
    return bool;
  }

  bool isAllDataValid() {
    var bool = (isUserNameValid(loginObject.email) &&
            isPasswordValid(loginObject.password))
        ? true
        : false;
    return bool;
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get userNameInput;

  Sink get passwordInput;

  Sink get allDataValidInput;
}

abstract class LoginViewModelOutput {
  Stream<bool> get userNameValid;

  Stream<bool> get passwordValid;

  Stream<bool> get allDataValid;
}
