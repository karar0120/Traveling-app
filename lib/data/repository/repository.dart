import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo networkInfo;
  final RemoteDataSource remoteDataSource;

  const RepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if (await networkInfo.isConnected) {
      try{
        final response = await remoteDataSource.login(loginRequests);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
        } else {
          return left(Failure(
              statusCode: ApiInternalStatus.FAILURE,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      }catch(error){
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.INTERNAL_SERVER_ERROR.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgetPassword>> forgetPassword(ForgetPasswordRequests forgetPasswordRequests) async{
    if (await networkInfo.isConnected) {
      try{
        final response = await remoteDataSource.forgetPassword(forgetPasswordRequests);
        if (response.status==ApiInternalStatus.SUCCESS){
          return right(response.toDomain());
        }else {
          return left(Failure(message:response.message ?? ResponseMessage.DEFAULT,
              statusCode: ApiInternalStatus.FAILURE ));
        }
      }catch (error){
        return left(ErrorHandler.handle(error).failure);
      }
    }else {
      return left(DataSource.INTERNAL_SERVER_ERROR.getFailure());
    }
  }
}
