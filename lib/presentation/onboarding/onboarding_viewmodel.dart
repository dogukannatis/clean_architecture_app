
import 'dart:async';

import 'package:clean_architecture_app/domain/model.dart';
import 'package:clean_architecture_app/presentation/base/base_view_model.dart';

import '../resources/assets_manager.dart';
import '../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs{

  final StreamController _streamController = StreamController<SliderViewObject>();

  late final List<SliderObject> _list;

  int _currentIndex = 0;


  // Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    /// Load data
    _list = _getSliderData();
    /// Send this slider data to our view.
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if(nextIndex >= _list.length){
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if(previousIndex == -1){
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // Outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);


  // Private Functions
  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubtitle1, ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubtitle2, ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubtitle3, ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubtitle4, ImageAssets.onBoardingLogo4),
  ];

  _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

}

/// Inputs mean the orders that our viewModel will receive from our view.
abstract class OnBoardingViewModelInputs {
  /// When user clicks on right arrow or swipe
  void goNext();
  /// When user clicks on left arrow or swipe
  void goPrevious();

  void onPageChanged(int index);

  /// This is the way to add data to the stream. - Stream Input
  Sink get inputSliderViewObject;
}

/// Outputs means data or results that will be sent from our viewModel to our view.
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject,this.numberOfSlides,this.currentIndex);
}