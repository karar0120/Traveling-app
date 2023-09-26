import 'package:tut_app/app/extension.dart';
import 'package:tut_app/data/responses/responses.dart';
import 'package:tut_app/domain/model/model.dart';
import '../../app/constance.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain(){
  return  Customer(
      id: this?.id.orEmpty()??Constance.empty,
      name: this?.name.orEmpty()??Constance.empty,
      numOfNotification: this?.numOfNotification.orZero()??Constance.zero);
  }
}


extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain(){
    return Contacts(
        phone: this?.phone.orEmpty()??Constance.empty,
        email: this?.email.orEmpty()??Constance.empty,
        link: this?.link.orEmpty()??Constance.empty);
  }
}


extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain(){
   return Authentication(
       customer: this?.customer.toDomain(),
       contacts: this?.contacts.toDomain());
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain(){
    return ForgetPassword(
    support: this?.support.orEmpty()??Constance.empty,
    );
  }
}
