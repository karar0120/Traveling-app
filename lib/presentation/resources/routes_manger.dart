import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/view/forget_password.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/view/on_boarding.dart';
import 'package:tut_app/presentation/register/view/register.dart';
import 'package:tut_app/presentation/resources/strings_manger.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/view/store_details.dart';

import '../../app/di.dart';
class Routes{
  static const String splashRoute="/";
  static const String loginRoute="/login";
  static const String registerRoute="/register";
  static const String forgetPasswordRoute="/forgetPassword";
  static const String mainRoute="/main";
  static const String onBoarding="/onBoarding";
  static const String storeDetailsRoute="/storeDetails";
}
class RouteGenerator{
  static Route<dynamic>getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder:(context)=>const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder:(context)=>const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder:(context)=>const Register());
      case Routes.forgetPasswordRoute:
        initForgetModule();
        return MaterialPageRoute(builder:(context)=>const ForgetPassword());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder:(context)=>const MainView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder:(context)=>const OnBoardingView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder:(context)=>const StoreDetails());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic>unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(title:  Text(AppString.noRouteFound.tr()),)
      ,body:  Center(child: Text(AppString.noRouteFound.tr())),
    ));
  }
}

