import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
  Future <ForgetPasswordResponse>forgetPassword (ForgetPasswordRequests forgetPasswordRequests);
  Future<AuthenticationResponse>register (RegisterRequests registerRequests);
  Future<HomeResponse>getHomeData ();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;

  const RemoteDataSourceImpl({required this.appServiceClient});

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await appServiceClient.login(
        loginRequests.email, loginRequests.password);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequests forgetPasswordRequests) async{
    return await appServiceClient.forgetPassword(forgetPasswordRequests.email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequests registerRequests) async{
   return await appServiceClient.register(
       registerRequests.userName,
       registerRequests.countryMobileCode,
       registerRequests.mobilePhone,
       registerRequests.email,
       registerRequests.password,
       "");
  }

  @override
  Future<HomeResponse> getHomeData() async{
   return await appServiceClient.home();

  }
}
