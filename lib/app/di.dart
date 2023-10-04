import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/login_use_case.dart';
import 'package:tut_app/domain/use_case/register_use_case.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';

import '../data/data_source/local_data_source.dart';
import '../domain/use_case/forget_password_use_case.dart';
import '../domain/use_case/home_use_case.dart';
import '../presentation/forget_password/view_model/forget_password_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance()));

  instance.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appPreferences: instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(appServiceClient: instance()));


  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImp());

  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(networkInfo: instance(), remoteDataSource: instance(),localDataSource: instance()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance()));

    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance()));
  }
}

Future<void> initForgetModule() async {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(repository: instance()));

    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(forgetPasswordUseCase: instance()));
  }
}

Future<void> initRegisterModule() async {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(repository: instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(registerUseCase: instance()));
    instance.registerFactory<ImagePicker>(
            () => ImagePicker());
  }
}

Future<void> initHomeModule() async {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<GetHomeDataUseCase>(
            () => GetHomeDataUseCase(repository: instance()));
    instance.registerFactory<HomeViewModel>(
            () => HomeViewModel(getHomeDataUseCase: instance()));
  }
}
