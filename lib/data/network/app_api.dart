import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut_app/app/constance.dart';

import '../responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constance.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(Constance.pathLogin)
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST(Constance.pathForgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Field('email') String email,
  );

  @POST(Constance.pathRegister)
  Future<AuthenticationResponse> register(
    @Field('user_name') String userName,
    @Field('country_mobile_code') String countryMobileCode,
    @Field('mobile_number') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('profile_picture') String profilePicture,
  );

  @GET(Constance.pathHome)
  Future<HomeResponse> home();

  @GET(Constance.pathStoreDetails)
  Future<StoreDetailsResponse> getStoreDetails();


}
