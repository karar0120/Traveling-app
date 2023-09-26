import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
  Future <ForgetPasswordResponse>forgetPassword (ForgetPasswordRequests forgetPasswordRequests);
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
}
