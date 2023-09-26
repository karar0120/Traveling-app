import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tut_app/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ForgetPasswordUseCaseInput, ForgetPassword> {
  final Repository repository;

  const ForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ForgetPassword>> execute(
      ForgetPasswordUseCaseInput input) async {
    return await repository
        .forgetPassword(ForgetPasswordRequests(email: input.email));
  }
}

class ForgetPasswordUseCaseInput extends Equatable {
  final String email;

  const ForgetPasswordUseCaseInput({required this.email});

  @override
  List<Object?> get props => [
    email,
  ];
}
