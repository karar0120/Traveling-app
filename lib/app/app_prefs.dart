

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/language_manger.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";

class AppPreferences {

  final SharedPreferences sharedPreferences;

  AppPreferences({required this.sharedPreferences});

  Future<String>getAppLanguage()async{
    String?language = sharedPreferences.getString(PREFS_KEY_LANG);
    if (language!=null&&language.isNotEmpty){
      return language;
    }else {
      sharedPreferences.setString(PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
      return LanguageType.ENGLISH.getValue();
    }
  }

  ///on boarding

  Future <void>setOnBoardingScreenViewed()async{
    sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future <bool>isOnBoardingViewScreenViewed()async{
   return sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED)??false;
  }

  ///Login


  Future <void>setUserLoginIn()async{
    sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future <bool>isUserLoginIn()async{
    return sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN)??false;
  }

}