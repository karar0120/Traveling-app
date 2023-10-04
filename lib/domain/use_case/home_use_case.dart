import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

class GetHomeDataUseCase extends BaseUseCase<void, Home> {
  Repository repository;

  GetHomeDataUseCase({required this.repository});

  @override
  Future<Either<Failure, Home>> execute(void input) async {
    return await repository.getHomeData();
  }
}
