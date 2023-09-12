import 'dart:async';

import 'package:mina_farid/domain/use_cases/forgot_usecace.dart';
import 'package:mina_farid/presentation/base/base_view_model.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_renderer_impl.dart';
import 'package:mina_farid/presentation/common/state_rerender/state_rerender.dart';
import 'package:mina_farid/presentation/resources/strings_manager.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _streamController =
      StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  late String _emailUserInput = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  setEmail(String email) {
    emailInput.add(email);
    _emailUserInput = email;
  }

  @override
  resetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase
            .execute(ForgotPasswordUseCaseInput(_emailUserInput)))
        .fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.massage));
    }, (data) {
      inputState.add(SuccessState(data.data!.email));
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
