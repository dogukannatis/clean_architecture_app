
abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // Shared variables and functions that will be used through any view model

}

abstract class BaseViewModelInputs {
  /// Will be called while init. of view model.
  void start();
  /// Will be called when viewModel dies.
  void dispose();
}

abstract class BaseViewModelOutputs {

}