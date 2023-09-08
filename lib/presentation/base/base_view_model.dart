import 'dart:async';

import 'package:mina_farid/presentation/common/state_rerender/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelOutput
    implements BaseViewModelInput {
  final StreamController _streamControllerState =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _streamControllerState.sink;

  @override
  Stream<FlowState> get outputState =>
      _streamControllerState.stream.map((flowState) => flowState);
  @override
  void dispose() {
    _streamControllerState.close();
  }
}

abstract class BaseViewModelInput {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}
