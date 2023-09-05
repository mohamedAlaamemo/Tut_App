import 'package:mina_farid/presentation/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  // TODO: implement userNameInput
  Sink get userNameInput => throw UnimplementedError();

  @override
  // TODO: implement passwordInput
  Sink get passwordInput => throw UnimplementedError();

  @override
  // TODO: implement passwordValid
  Stream<bool> get passwordValid => throw UnimplementedError();

  @override
  // TODO: implement userNameValid
  Stream<bool> get userNameValid => throw UnimplementedError();
}

abstract class LoginViewModelInput {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get userNameInput;

  Sink get passwordInput;
}

abstract class LoginViewModelOutput {
  Stream<bool> get userNameValid;

  Stream<bool> get passwordValid;
}
