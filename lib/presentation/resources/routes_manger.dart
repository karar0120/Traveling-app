import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/forget_password.dart';
import 'package:tut_app/presentation/login/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/onboarding/on_boarding.dart';
import 'package:tut_app/presentation/register/register.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/store_details.dart';

import 'Strings_Manger.dart';
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
        return MaterialPageRoute(builder:(context)=>const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder:(context)=>const Register());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder:(context)=>const ForgetPassword());
      case Routes.mainRoute:
        return MaterialPageRoute(builder:(context)=>const MainView());
      case Routes.onBoarding:
        return MaterialPageRoute(builder:(context)=>const OnBoardingView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder:(context)=>const StoreDetails());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic>unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(title: const Text(AppString.noRouteFound),)
      ,body: const Center(child: Text(AppString.noRouteFound)),
    ));
  }
}

