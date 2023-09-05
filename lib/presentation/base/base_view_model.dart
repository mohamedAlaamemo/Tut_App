abstract class BaseViewModel extends BaseViewModelOutput
    implements BaseViewModelInput {}

abstract class BaseViewModelInput {
  void start();

  void dispose();
}

abstract class BaseViewModelOutput {}
