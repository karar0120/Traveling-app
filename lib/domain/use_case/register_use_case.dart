import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/repository/repository.dart';
import 'package:tut_app/domain/use_case/base_use_case.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await repository.register(RegisterRequests(
        userName: input.userName,
        countryMobileCode: input.countryMobileCode,
        mobilePhone: input.mobilePhone,
        email: input.email,
        password: input.password,
        profilePicture: input.profilePicture));
  }
}

class RegisterUseCaseInput extends Equatable {
  final String userName;
  final String countryMobileCode;
  final String mobilePhone;
  final String email;
  final String password;
  final String profilePicture;

  const RegisterUseCaseInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobilePhone,
    required this.email,
    required this.password,
    required this.profilePicture,
  });

  @override
  List<Object?> get props => [
        userName,
        countryMobileCode,
        mobilePhone,
        email,
        password,
        profilePicture
      ];
}
