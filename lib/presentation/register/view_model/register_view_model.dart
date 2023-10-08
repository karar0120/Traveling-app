import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/domain/use_case/register_use_case.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';

import '../../../app/function.dart';
import '../../resources/strings_manger.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final RegisterUseCase registerUseCase;
  RegisterViewModel({required this.registerUseCase});

  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final StreamController isUserRegisteredInSuccessfullyStreamController =
  StreamController<bool>();

  var registerObject =RegisterObject("","", "", "", "", "");

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _mobileNumberStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    super.dispose();
  }

  ///input
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobilePhone => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;


  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;


  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    if (_isUserNameValid(userName)){
     registerObject= registerObject.copyWith(userName: userName);
    }else {
      registerObject= registerObject.copyWith(userName: "");
    }

    _validate();
  }


  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty){
      registerObject= registerObject.copyWith(countryMobilePhone: countryCode);
    }else {
      registerObject= registerObject.copyWith(countryMobilePhone: "");
    }

    _validate();
  }

  @override
  setEmail(String email) {
    _emailStreamController.add(email);
    if (isEmailValid(email)){
      registerObject= registerObject.copyWith(email: email);
    }else {
      registerObject= registerObject.copyWith(email: "");
    }

    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    _mobileNumberStreamController.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)){
      registerObject= registerObject.copyWith(mobileNumber: mobileNumber);
    }else {
      registerObject= registerObject.copyWith(mobileNumber: "");
    }

    _validate();
  }

  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
    if (_isPasswordValid(password)){
      registerObject= registerObject.copyWith(password: password);
    }else {
      registerObject= registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    _profilePictureStreamController.add(profilePicture);
    if (profilePicture.path.isNotEmpty){
      registerObject= registerObject.copyWith(profilePicture: profilePicture.path);
    }else {
      registerObject= registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }




  ///output


  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((isUserNameValid) => _isUserNameValid(isUserNameValid));

  @override
  Stream<String?> get outputErrorUserName =>
      outputIsUserNameValid.map((isUserName) =>
      isUserName ? null : AppString.userNameInvalid.tr()
      );

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream
      .map((isRegisterEmailValid) => isEmailValid(isRegisterEmailValid));

  @override
  Stream<String?> get outputErrorEmail =>
      outputIsEmailValid.map((email) => email ? null : AppString.invalidEmail.tr());

  @override
  Stream<bool> get outputIsMobilePhoneValid => _mobileNumberStreamController
      .stream
      .map((isMobileNumberValid) => _isMobileNumberValid(isMobileNumberValid));

  @override
  Stream<String?> get outputErrorMobilePhone =>
      outputIsMobilePhoneValid.map((isMobilePhoneWrong) =>
          isMobilePhoneWrong ? null : AppString.mobileNumberInvalid.tr());

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((isPasswordValid) => _isPasswordValid(isPasswordValid));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
      (isPasswordWrong) => isPasswordWrong ? null : AppString.passwordInvalid.tr());

  @override
  Stream<File> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid => _areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  register() async{
   inputState.add(LoadingState(stateRendererType:StateRendererType.popupLoadingState));
   ( await registerUseCase.execute(RegisterUseCaseInput(
       userName: registerObject.userName,
       countryMobileCode: registerObject.countryMobilePhone,
       mobilePhone: registerObject.mobileNumber,
       email: registerObject.email,
       password:registerObject.password,
       profilePicture: registerObject.profilePicture))).fold((failure) => inputState.add(ErrorState(
       stateRendererType: StateRendererType.popupErrorState,
       message: failure.message!)),
           (data) {
             inputState.add(ContentState());
             isUserRegisteredInSuccessfullyStreamController.add(true);
           });
  }

  ///privateFunction
  _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  _isPasswordValid(String password) {
    return password.length >= 6;
  }

  _areAllInputsValid(){
   return registerObject.countryMobilePhone.isNotEmpty&&
        registerObject.mobileNumber.isNotEmpty&&
        registerObject.userName.isNotEmpty&&
        registerObject.email.isNotEmpty&&
        registerObject.password.isNotEmpty&&
        registerObject.profilePicture.isNotEmpty;
  }
  _validate(){
    _areAllInputsValidStreamController.add(null);
  }





}

abstract class RegisterViewModelInput {
  Sink get inputUserName;

  Sink get inputMobilePhone;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  setUserName(String userName);
  setPassword(String password);
  setEmail(String email);
  setMobileNumber(String mobileNumber);
  setProfilePicture(File profilePicture);
  setCountryCode(String countryCode);


  register();

  Sink get  inputAllInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobilePhoneValid;

  Stream<String?> get outputErrorMobilePhone;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;


  Stream<bool> get outputAreAllInputsValid;

}
