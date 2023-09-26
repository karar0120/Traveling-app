import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../app/app_prefs.dart';
import '../../resources/Strings_Manger.dart';
import '../../resources/image_manger.dart';
import '../../resources/routes_manger.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginViewModel = instance<LoginViewModel>();
  final TextEditingController _useNameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences =instance<AppPreferences>();
  _bind() {
    loginViewModel.start();
    _useNameTextEditingController.addListener(
        () => loginViewModel.setUserName(_useNameTextEditingController.text));
    _passwordTextEditingController.addListener(
        () => loginViewModel.setPassword(_passwordTextEditingController.text));
    loginViewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoginIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: StreamBuilder<StateFlow>(
        stream: loginViewModel.getOutputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context: context,
                  contentScreenWidget: _getContentWidget(),
                  retryActionFunction: () {}) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image.asset(ImageManger.splashScreen),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: loginViewModel.outIsUserNameValid,
                  builder: (context, snapShot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _useNameTextEditingController,
                      decoration: InputDecoration(
                        hintText: AppString.username,
                        labelText: AppString.username,
                        errorText: (snapShot.data ?? true)
                            ? null
                            : AppString.usernameError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: loginViewModel.outIsPasswordValid,
                  builder: (context, snapShot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordTextEditingController,
                      decoration: InputDecoration(
                        hintText: AppString.password,
                        labelText: AppString.password,
                        errorText: (snapShot.data ?? true)
                            ? null
                            : AppString.passwordError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: loginViewModel.outAreAllInputsValid,
                  builder: (context, snapShot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapShot.data ?? false)
                              ? () {
                                  loginViewModel.login();
                                }
                              : null,
                          child: const Text(AppString.login)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppString.forgetPassword,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(
                        AppString.registerText,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    loginViewModel.dispose();
    super.dispose();
  }
}
