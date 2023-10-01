import 'package:equatable/equatable.dart';

class LoginRequests extends Equatable {
  final String email;
  final String password;

  const LoginRequests({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgetPasswordRequests extends Equatable {
  final String email;

  const ForgetPasswordRequests({required this.email});

  @override
  List<Object?> get props => [
        email,
      ];
}

class RegisterRequests extends Equatable {
  final String userName;
  final String countryMobileCode;
  final String mobilePhone;
  final String email;
  final String password;
  final String profilePicture;

  const RegisterRequests({
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
