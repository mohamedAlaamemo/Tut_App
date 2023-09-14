import 'dart:async';
import 'dart:io';

import 'package:mina_farid/app/di.dart';
import 'package:mina_farid/domain/use_cases/register_usecase.dart';
import 'package:mina_farid/presentation/base/base_view_model.dart';
import 'package:mina_farid/presentation/common/freezed_data.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_renderer_impl.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_rerender.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profileImageStreamController =
      StreamController<File>.broadcast();
  final StreamController _allDataValidStreamController =
      StreamController<void>.broadcast();

  RegisterObject registerObject = RegisterObject("", "+20", "", "", "", "");

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _allDataValidStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _phoneStreamController.close();
    _profileImageStreamController.close();
    _emailStreamController.close();
    super.dispose();
  }

  @override
  setCountryCode(String countryCode) {
    registerObject = registerObject.copyWith(countryCode: countryCode);
    print(registerObject.countryCode);
    _updateCheckValidData();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (email.length > 8) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _updateCheckValidData();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (mobileNumber.length > 10) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _updateCheckValidData();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);

    if (password.length > 5) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _updateCheckValidData();
  }

  @override
  setProfileImage(File image) {
    inputImage.add(image);
    if (image.path.isNotEmpty) {
      registerObject = registerObject.copyWith(imagePath: image.path);
    } else {
      registerObject = registerObject.copyWith(imagePath: "");
    }
    _updateCheckValidData();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (userName.length > 5) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    _updateCheckValidData();
  }

  @override
  register() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.userName,
            registerObject.countryCode,
            registerObject.mobileNumber,
            registerObject.email,
            registerObject.password,
            "")))
        .fold((failure) {
      inputState.add(ErrorState(StateRendererType.popupErrorState, failure.massage));
    }, (data) {

          inputState.add(ContentState());


    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputImage => _profileImageStreamController.sink;

  @override
  Sink get inputMobileNumber => _phoneStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllDataValid => _allDataValidStreamController.sink;

  @override
  Stream<String?> get outputEmail => _emailStreamController.stream.map((email) {
        return (registerObject.email == "") ? AppStrings.invalidEmail : null;
      });

  @override
  Stream<File> get outputImage =>
      _profileImageStreamController.stream.map((image) => image);

  @override
  Stream<String?> get outputMobileNumber =>
      _phoneStreamController.stream.map((event) {
        return (registerObject.mobileNumber == "")
            ? AppStrings.mobileNumberInvalid
            : null;
      });

  @override
  Stream<String?> get outputPassword =>
      _passwordStreamController.stream.map((event) {
        return (registerObject.password == "")
            ? AppStrings.passwordError
            : null;
      });

  @override
  Stream<String?> get outputUserName =>
      _userNameStreamController.stream.map((event) {
        return (registerObject.userName == "")
            ? AppStrings.usernameError
            : null;
      });

  @override
  Stream<bool> get outputAllDataValid =>
      _allDataValidStreamController.stream.map((_) => _checkAllDataAreValid());

  // private fun

  bool _checkAllDataAreValid() {
    if (registerObject.userName != "" &&
        registerObject.mobileNumber != "" &&
        registerObject.email != "" &&
        registerObject.password != "" &&
        registerObject.imagePath != "" &&
        registerObject.countryCode != "") {
      return true;
    }
    return false;
  }

  _updateCheckValidData() {
    inputAllDataValid.add(null);
  }
}

abstract class RegisterViewModelOutput {
  setUserName(String userName);

  setCountryCode(String countryCode);

  setMobileNumber(String mobileNumber);

  setEmail(String email);

  setPassword(String password);

  setProfileImage(File image);

  register();

  // input data
  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputImage;

  Sink get inputAllDataValid;
}

abstract class RegisterViewModelInput {
  Stream<String?> get outputUserName;

  Stream<String?> get outputMobileNumber;

  Stream<String?> get outputEmail;

  Stream<String?> get outputPassword;

  Stream<File> get outputImage;

  Stream<bool> get outputAllDataValid;
}
