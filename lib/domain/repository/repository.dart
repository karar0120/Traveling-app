import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/requests.dart';
abstract class Repository{

  Future<Either<Failure,Authentication>>login(LoginRequests loginRequests);

  Future<Either<Failure,ForgetPassword>>forgetPassword(ForgetPasswordRequests forgetPasswordRequests );
  Future <Either<Failure,Authentication>>register(RegisterRequests registerRequests);
  Future<Either<Failure,Home>>getHomeData();

}