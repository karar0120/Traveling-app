import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

import '../model/model.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository repository;

  const LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await repository
        .login(LoginRequests(email: input.email, password: input.password));
  }
}

class LoginUseCaseInput extends Equatable {
  final String email;
  final String password;

  const LoginUseCaseInput({required this.email, required this.password});

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
