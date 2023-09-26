import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/forget_password/view_model/forget_password_view_model.dart';

import '../../common/state_renderer/state_renderer_imp.dart';
import '../../resources/Strings_Manger.dart';
import '../../resources/image_manger.dart';
import '../../resources/values_manger.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordViewModel forgetPasswordViewModel =instance<ForgetPasswordViewModel>();
  final TextEditingController _emailTextEditingController=TextEditingController();
  final GlobalKey _formKey =GlobalKey<FormState>();
  _bind(){
    forgetPasswordViewModel.start();
    _emailTextEditingController.addListener(() {
      forgetPasswordViewModel.setEmail(_emailTextEditingController.text);
    });
 }

  @override
  void initState() {
    super.initState();
    _bind();
  }
@override
  void dispose() {
    forgetPasswordViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:StreamBuilder<StateFlow>(
        stream:forgetPasswordViewModel.getOutputState,
        builder: (context,snapshot) {
          return snapshot.data?.getScreenWidget(
              context: context,
              contentScreenWidget: _getContentWidget(),
              retryActionFunction:(){} )??_getContentWidget();
        }
      ) ,
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
                  stream: forgetPasswordViewModel.outIsEmailValid,
                  builder: (context, snapShot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextEditingController,
                      decoration: InputDecoration(
                        hintText: AppString.emailHint,
                        labelText: AppString.emailHint,
                        errorText: (snapShot.data ?? true)
                            ? null
                            : AppString.emailError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: forgetPasswordViewModel.outputIsAllInputValid,
                  builder: (context, snapShot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapShot.data ?? false)
                              ? () {
                            forgetPasswordViewModel.forgetPassword();
                          }
                              : null,
                          child: const Text(AppString.resetPassword)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
