import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {

  final sharedPreferences = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() =>sharedPreferences);

  instance.registerLazySingleton<AppPreferences>(() =>AppPreferences(sharedPreferences: instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(appPreferences: instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(() =>RemoteDataSourceImpl(appServiceClient: instance()));

  instance.registerLazySingleton<Repository>(() =>RepositoryImpl(networkInfo: instance(),
      remoteDataSource: instance()));

}
Future<void >initLoginModule() async{

  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() =>
        LoginUseCase(repository: instance()));

    instance.registerFactory<LoginViewModel>(() =>
        LoginViewModel(loginUseCase: instance()));
  }
}