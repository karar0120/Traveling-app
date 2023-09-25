import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/image_manger.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/Color_Manger.dart';
import '../resources/constants_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDaley() {
    _timer =
        Timer(const Duration(seconds: ConstantsManger.splashView), _geNext);
  }

  _geNext() {
    _appPreferences.isUserLoginIn().then((isUserLoginIn) => {
          if (isUserLoginIn)
            {
              Navigator.pushReplacementNamed(
                  context, Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingViewScreenViewed()
                  .then((isOnBoardingViewScreenViewed) => {
                        if (isOnBoardingViewScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoarding)
                          }
                      })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDaley();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: Center(
        child: Image.asset(ImageManger.splashScreen),
      ),
    );
  }

  @override
  void dispose() {
    _timer;
    super.dispose();
  }
}
