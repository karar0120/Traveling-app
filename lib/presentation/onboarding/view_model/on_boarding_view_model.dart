import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import '../../resources/image_manger.dart';
import '../../resources/strings_manger.dart';

class OnBoardingViewModel extends BaseViewModel implements OnBoardingViewModelInput,OnBoardingViewModelOutput{

  StreamController streamController =StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;
  @override
  void dispose() {
    streamController.close();
    // TODO: implement dispose
  }

  @override
  void start() {
    _list=_getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChange(int index) {
    _currentIndex=index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      streamController.stream.map((sliderViewObject) => sliderViewObject);


  List<SliderObject> _getSliderData() => [
     SliderObject(AppString.onBoardingTitle1.tr(),
        AppString.onBoardingSubTitle1.tr(), ImageManger.onBoarding1),
     SliderObject(AppString.onBoardingTitle2.tr(),
        AppString.onBoardingSubTitle2.tr(), ImageManger.onBoarding2),
     SliderObject(AppString.onBoardingTitle3.tr(),
        AppString.onBoardingSubTitle3.tr(), ImageManger.onBoarding3),
     SliderObject(AppString.onBoardingTitle4.tr(),
        AppString.onBoardingSubTitle4.tr(), ImageManger.onBoarding4),
  ];

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex],
        _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInput{

  int goNext();
  int goPrevious();
  void onPageChange(int index);

  Sink get inputSliderViewObject;
}


abstract class OnBoardingViewModelOutput{

  Stream get outputSliderViewObject;
}