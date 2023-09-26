import 'dart:async';

import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/use_case/forget_password_use_case.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';

import '../../../app/function.dart';

class ForgetPasswordViewModel extends BaseViewModel implements ForgetPasswordInput,ForgetPasswordOutput {
  final StreamController _emailStreamController =
  StreamController<String>.broadcast( );

  final StreamController _areAllInputValidStreamController =
  StreamController<void>.broadcast();

  var email = "";
  final ForgetPasswordUseCase forgetPasswordUseCase ;
  ForgetPasswordViewModel({required this.forgetPasswordUseCase});
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputValidStreamController.close();
  }

  @override
  forgetPassword() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await forgetPasswordUseCase.execute(ForgetPasswordUseCaseInput(email: email))).fold(
            (failure) {
              inputState.add(ErrorState(stateRendererType:StateRendererType.popupErrorState,
                  message: failure.message!));
            } ,
            (r) {
              inputState.add(SuccessState(r.support));
            });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email=email;
    _validate();
  }

  @override

  Sink get inputIsAllInputValid => _areAllInputValidStreamController.sink;

  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid => _areAllInputValidStreamController.stream.map((isAllInputValid) =>_isAllInputValid());

  @override
  Stream<bool> get outIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  _isAllInputValid(){
    return isEmailValid(email);
  }
  _validate() {
    inputIsAllInputValid.add(null);
  }

}

abstract class ForgetPasswordInput{
  setEmail(String email);
  
  forgetPassword();
  
  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}
abstract class ForgetPasswordOutput{
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}