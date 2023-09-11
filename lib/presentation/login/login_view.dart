import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManger.primary,
        body: Container());
  }
}
