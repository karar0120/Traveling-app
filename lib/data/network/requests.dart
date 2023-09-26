import 'package:equatable/equatable.dart';

class LoginRequests extends Equatable{
  final String email;
  final String password;
  const LoginRequests({required this.email,required this.password});

  @override
  List<Object> get props => [
    email,
    password
  ];


}

class ForgetPasswordRequests extends Equatable {
  final String email;
 const ForgetPasswordRequests ({required this.email});

  @override
  List<Object?> get props => [
    email,
  ];
}