import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
import 'package:tut_app/presentation/resources/image_manger.dart';
import 'package:tut_app/presentation/resources/style_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../resources/Fonts_Manger.dart';
import '../../resources/Strings_Manger.dart';

enum StateRendererType {
  ///popup State
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  /// fullScreen State
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  /// general
  contentState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;

  const StateRenderer({
    super.key,
    required this.stateRendererType,
    this.message = AppString.loading,
    this.title="",
    required this.retryActionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context){
    switch(stateRendererType){
      case StateRendererType.popupLoadingState:
       return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.loading),
        ]);
      case StateRendererType.popupErrorState:
       return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.ok,context)
        ]);
      case StateRendererType.popupSuccessState:
        return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.success),
          _getMessage(title),
          _getMessage(message),
          _getRetryButton(AppString.ok,context)
        ]);
      case StateRendererType.fullScreenLoadingState:
       return _getItemColumn([
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
       return _getItemColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppString.retryAgain,context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }


  Widget _getPopUpDialog(context,List<Widget>children) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.s14),
    ),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: ColorManger.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppSize.s14),
        boxShadow: const [BoxShadow(color: Colors.black26)],
      ),
      child: _getDialogContent(context,children),
    ),
  );
  }
  Widget _getDialogContent(context,List<Widget>children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
    }


 Widget _getItemColumn(List<Widget>children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
 }


 Widget _getAnimatedImage(animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName)
    );
 }

 Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,style:getRegularStyle(color:ColorManger.black,fontSize: FontSizeManger.s18) ,),
      ),
    );
 }

 Widget _getRetryButton(String buttonTitle,BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: (){
            if (stateRendererType==StateRendererType.fullScreenErrorState){
              retryActionFunction.call();
            }else{
             Navigator.of(context).pop();
            }
          },
              child: Text(buttonTitle)),
        ),
      ),
    );
 }
}

