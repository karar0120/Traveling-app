import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/constance.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';

import '../../resources/strings_manger.dart';

abstract class StateFlow {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends StateFlow {
  final StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, this.message = AppString.loading});

  @override
  String getMessage() => message ?? AppString.loading.tr();

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends StateFlow {
  final StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends StateFlow {
  ContentState();

  @override
  String getMessage() => Constance.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends StateFlow {
  final String message;

  EmptyState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}
class SuccessState extends StateFlow {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccessState;
}


extension StateFlowExtension on StateFlow {
  Widget getScreenWidget(
      {required BuildContext context,
      required Widget contentScreenWidget,
      required Function retryActionFunction}) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType()==StateRendererType.popupLoadingState){
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          }else {
          return  StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction:retryActionFunction,);
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType()==StateRendererType.popupErrorState){
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          }else {
           return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction:retryActionFunction,);
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: (){},
          );
        }
      case SuccessState:
        {
          // i should check if we are showing loading popup to remove it before showing success popup
          dismissDialog(context);

          // show popup
          showPopUp(
              context, StateRendererType.popupSuccessState,
              getMessage(),
              title : AppString.success.tr());
          // return content ui of the screen
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
         return contentScreenWidget;
        }
    }
  }


  _isCurrentDialogShowing(context)=>ModalRoute.of(context)?.isCurrent !=true;

  dismissDialog(context){
    if (_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }



  showPopUp(BuildContext context,StateRendererType stateRendererType, String message, {String title = Constance.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context,
          builder:(context)=>StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              title: title,
              retryActionFunction: (){}));
    });
  }
}
