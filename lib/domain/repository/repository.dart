import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/requests.dart';
abstract class Repository{

  Future<Either<Failure,Authentication>>login(LoginRequests loginRequests);

}