import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
import 'package:tut_app/presentation/resources/constants_manger.dart';
import 'package:tut_app/presentation/resources/image_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';
import '../../../app/di.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../view_model/on_boarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageController = PageController();
  final OnBoardingViewModel onBoardingViewModel =OnBoardingViewModel();
  final AppPreferences _appPreferences =instance<AppPreferences>();

  _bind(){
    _appPreferences.setOnBoardingScreenViewed();
    onBoardingViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }
  @override
  void dispose() {
    onBoardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: onBoardingViewModel.outputSliderViewObject,
        builder: (context,snapShot){
      return _getContentWidget(snapShot.data);
    });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if (sliderViewObject!=null){
      return Scaffold(
        backgroundColor: ColorManger.white,
        appBar: AppBar(
          backgroundColor: ColorManger.white,
          elevation: AppSize.s0,
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObject.numOfSliders,
          onPageChanged: (index) {
            onBoardingViewModel.onPageChange(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManger.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _appPreferences.setOnBoardingScreenViewed();
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppString.skip.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),

              // widgets indicator and arrows
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }else {
      return Container();
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageManger.arrowRight),
              ),
              onTap: () {
                _pageController.animateToPage(onBoardingViewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: ConstantsManger.pageViewTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSliders; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i,sliderViewObject.currentIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageManger.arrowLeft),
                ),
                onTap: () {
                  // go to previous slide
                  _pageController.animateToPage(onBoardingViewModel.goNext(),
                      duration: const Duration(
                          milliseconds: ConstantsManger.pageViewTime),
                      curve: Curves.bounceInOut);
                }),
          )
        ],
      ),
    );
  }



  Widget _getProperCircle(int index,int currentIndex) {
    if (index ==currentIndex ) {
      return SvgPicture.asset(ImageManger.hollowCircle);
    } else {
      return SvgPicture.asset(ImageManger.solidCircle);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}
