import 'package:tut_app/app/extension.dart';

import 'package:tut_app/domain/model/model.dart';
import '../../app/constance.dart';
import '../responses/responses.dart';

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


extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain(){
    return Service(
      id:this?.id.orZero()??Constance.zero,
      title:this?.title.orEmpty()??Constance.empty,
      image:this?.image.orEmpty()??Constance.empty,
    );
  }
}
extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain(){
    return BannerAd(
      id:this?.id.orZero()??Constance.zero,
      title:this?.title.orEmpty()??Constance.empty,
      image:this?.image.orEmpty()??Constance.empty,
    );
  }
}
extension StoreResponseMapper on StoreResponse? {
  Store toDomain(){
    return Store(
      id:this?.id.orZero()??Constance.zero,
      title:this?.title.orEmpty()??Constance.empty,
      image:this?.image.orEmpty()??Constance.empty,
    );
  }
}


extension HomeResponseMapper on HomeResponse? {
  Home toDomain(){
    List<Service> service =(this?.data?.service?.map((serviceResponse) =>serviceResponse.toDomain())
        ??const Iterable.empty()).cast<Service>().toList();

    List<BannerAd> banner =(this?.data?.banner?.map((bannerResponse) =>bannerResponse.toDomain())
        ??const Iterable.empty()).cast<BannerAd>().toList();

    List<Store> store =(this?.data?.store?.map((storeResponse) =>storeResponse.toDomain())
        ??const Iterable.empty()).cast<Store>().toList();

    var data =DataHome(service:service,banner:banner ,store:store );
    return Home(
      data:data
    );
  }
}