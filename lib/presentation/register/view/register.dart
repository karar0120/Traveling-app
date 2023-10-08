import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/app/constance.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../app/app_prefs.dart';
import '../../resources/image_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterViewModel registerViewModel =instance<RegisterViewModel>();
  final ImagePicker _imagePicker =instance<ImagePicker>();
  final AppPreferences _appPreferences =instance<AppPreferences>();

  final GlobalKey _formKey=GlobalKey<FormState>();

  final TextEditingController _userNameTextEditingController =TextEditingController();

  final TextEditingController _emailTextEditingController =TextEditingController();

  final TextEditingController _passwordTextEditingController =TextEditingController();

  final TextEditingController _mobileNumberTextEditingController =TextEditingController();


  _bind(){
  registerViewModel.start();
  _userNameTextEditingController.addListener(() {
    registerViewModel.setUserName(_userNameTextEditingController.text);
  });

  _emailTextEditingController.addListener(() {
    registerViewModel.setEmail(_emailTextEditingController.text);
  });

  _passwordTextEditingController.addListener(() {
    registerViewModel.setPassword(_passwordTextEditingController.text);
  });

  _mobileNumberTextEditingController.addListener(() {
    registerViewModel.setMobileNumber(_mobileNumberTextEditingController.text);
  });

  registerViewModel.isUserRegisteredInSuccessfullyStreamController.stream
      .listen((isRegister) {
    if (isRegister) {
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
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
        iconTheme: const IconThemeData(color: ColorManger.primary),
      ),
      body: StreamBuilder<StateFlow>(
          stream: registerViewModel.getOutputState,
          builder: (context,snapshot)=>snapshot.data?.getScreenWidget(
              context: context,
              contentScreenWidget: _getContentWidget(),
              retryActionFunction: (){})??_getContentWidget()),
    );
  }

 Widget _getContentWidget(){
   return Container(
     padding: const EdgeInsets.only(top: AppPadding.p28),
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
               child: StreamBuilder<String?>(
                 stream: registerViewModel.outputErrorUserName,
                 builder: (context, snapShot) {
                   return TextFormField(
                     keyboardType: TextInputType.name,
                     controller: _userNameTextEditingController,
                     decoration: InputDecoration(
                       hintText: AppString.username.tr(),
                       labelText: AppString.username.tr(),
                       errorText: snapShot.data
                     ),
                   );
                 },
               ),
             ),
             const SizedBox(
               height: AppSize.s18,
             ),
             Center(
               child: Padding(padding: const EdgeInsets.only(
               left: AppPadding.p28, right: AppPadding.p28),
               child: Row(
                 children: [
                   Expanded(
                       flex: 1,
                       child:CountryCodePicker(
                         onChanged: (country){
                           registerViewModel.setCountryCode(country.dialCode??Constance.token);
                         },
                         initialSelection: '+20',
                         favorite: const ['+39','FR',"+966"],
                         showCountryOnly: true,
                         showOnlyCountryWhenClosed: true,
                         hideMainText: true,
                         alignLeft: false,
                       ),
               ),
                   Expanded(
                       flex: 4,
                       child: StreamBuilder<String?>(
                         stream: registerViewModel.outputErrorMobilePhone,
                         builder: (context, snapShot) {
                           return TextFormField(
                             keyboardType: TextInputType.phone,
                             controller: _mobileNumberTextEditingController,
                             decoration: InputDecoration(
                                 hintText: AppString.mobileNumber.tr(),
                                 labelText: AppString.mobileNumber.tr(),
                                 errorText: snapShot.data
                             ),
                           );
                         },
                       ))
                 ],
               ),),
             ),
             const SizedBox(
               height: AppSize.s18,
             ),
             Padding(
               padding: const EdgeInsets.only(
                   left: AppPadding.p28, right: AppPadding.p28),
               child: StreamBuilder<String?>(
                 stream: registerViewModel.outputErrorEmail,
                 builder: (context, snapShot) {
                   return TextFormField(
                     keyboardType: TextInputType.emailAddress,
                     controller: _emailTextEditingController,
                     decoration: InputDecoration(
                         hintText: AppString.emailHint.tr(),
                         labelText: AppString.emailHint.tr(),
                         errorText: snapShot.data
                     ),
                   );
                 },
               ),
             ),
             const SizedBox(
               height: AppSize.s18,
             ),
             Padding(
               padding: const EdgeInsets.only(
                   left: AppPadding.p28, right: AppPadding.p28),
               child: StreamBuilder<String?>(
                 stream: registerViewModel.outputErrorPassword,
                 builder: (context, snapShot) {
                   return TextFormField(
                     keyboardType: TextInputType.visiblePassword,
                     controller: _passwordTextEditingController,
                     decoration: InputDecoration(
                       hintText: AppString.password.tr(),
                       labelText: AppString.password.tr(),
                       errorText: snapShot.data
                     ),
                   );
                 },
               ),
             ),
             const SizedBox(
               height: AppSize.s18,
             ),

             Padding(
               padding: const EdgeInsets.only(
                   left: AppPadding.p28, right: AppPadding.p28),
               child: Container(
                 height: AppSize.s40,
                 decoration: BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                   border: Border.all(color: ColorManger.gray),
                 ),
                 child: GestureDetector(
                   child: _getMediaWidget(),
                   onTap: (){
                        _showPicker(context);
                   },
                 ),
               ),
             ),

             const SizedBox(
               height: AppSize.s40,
             ),
             Padding(
               padding: const EdgeInsets.only(
                   left: AppPadding.p28, right: AppPadding.p28),
               child: StreamBuilder<bool>(
                 stream: registerViewModel.outputAreAllInputsValid,
                 builder: (context, snapShot) {
                   return SizedBox(
                     width: double.infinity,
                     height: AppSize.s40,
                     child: ElevatedButton(
                         onPressed: (snapShot.data ?? false)
                             ? () {
                           registerViewModel.register();
                         }
                             : null,
                         child:  Text(AppString.register.tr())),
                   );
                 },
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(
                   top: AppPadding.p18,
                   left: AppPadding.p28,
                   right: AppPadding.p28),
               child: TextButton(
                 onPressed: () {
                   Navigator.of(context).pop();
                 },
                 child: Text(
                   AppString.alreadyHaveAccount.tr(),
                   style: Theme.of(context).textTheme.titleMedium,
                 ),
               )
             )
           ],
         ),
       ),
     ),
   );
  }
 Widget _getMediaWidget(){
    return Padding(padding: const EdgeInsets.only(
      left: AppPadding.p8,right: AppPadding.p8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Flexible(child: Text(AppString.profilePicture.tr())),
        Flexible(child: StreamBuilder<File>(
          stream: registerViewModel.outputProfilePicture,
          builder: (context,snapshot){
            return _imagePickerByUser(snapshot.data);
          },
        )),
        Flexible(child: SvgPicture.asset(ImageManger.profilePicture)),
      ],
    ),
    );
  }

  Widget _imagePickerByUser(File? image){
    if (image!=null && image.path.isNotEmpty){
      return Image.file(image);
    }else {
      return Container();
    }
  }

  _showPicker(context) async{
     showModalBottomSheet(context: context, builder: (context){
      return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title:  Text(AppString.photoGallery.tr()),
                onTap: (){
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title:  Text(AppString.photoCamera.tr()),
                onTap: (){
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
      ));
    });
  }

  _imageFromCamera()async{
    var image=await _imagePicker.pickImage(source: ImageSource.camera);
    registerViewModel.setProfilePicture(File(image?.path??Constance.empty));
  }
  _imageFromGallery()async{
    var image=await _imagePicker.pickImage(source: ImageSource.gallery);
    registerViewModel.setProfilePicture(File(image?.path??Constance.empty));
  }
  @override
  void dispose() {
    registerViewModel.dispose();
    super.dispose();
  }
}
