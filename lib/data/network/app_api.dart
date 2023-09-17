import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut_app/app/constance.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';
@RestApi(baseUrl:Constance.baseUrl)

abstract class AppServiceClient{

  factory AppServiceClient(Dio dio , {String baseUrl})= _AppServiceClient;

  @POST(Constance.pathLogin)

  Future<AuthenticationResponse> login (
  @Field('email')
  String email,
  @Field('password')
  String password,
  );

}