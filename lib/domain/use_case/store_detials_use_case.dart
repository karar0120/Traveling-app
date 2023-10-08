import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

class StoreDetailsUseCase extends BaseUseCase<void,StoreDetails>{

  final Repository repository;

  StoreDetailsUseCase({required this.repository});
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async{
   return await repository.getStoreDetailsData();
  }

}