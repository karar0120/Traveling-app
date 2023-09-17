abstract class BaseViewModel extends BaseViewModelInput implements BaseViewModelOutput {

}

abstract class BaseViewModelInput {
  void start();

  void dispose();
}

abstract class BaseViewModelOutput {}
