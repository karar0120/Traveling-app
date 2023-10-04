import 'package:equatable/equatable.dart';

class SliderObject extends Equatable {
  final String title;
  final String subTitle;
  final String image;

  const SliderObject(this.title, this.subTitle, this.image);

  @override
  List<Object> get props => [title, subTitle, image];
}

class SliderViewObject extends Equatable {
  final SliderObject sliderObject;
  final int numOfSliders;
  final int currentIndex;

  const SliderViewObject(
      this.sliderObject, this.numOfSliders, this.currentIndex);

  @override
  List<Object?> get props => [
        sliderObject,
        numOfSliders,
        currentIndex,
      ];
}

class Customer extends Equatable {
  final String id;
  final String name;
  final int numOfNotification;

  const Customer(
      {required this.id, required this.name, required this.numOfNotification});

  @override
  List<Object> get props => [
        id,
        name,
        numOfNotification,
      ];
}

class Contacts extends Equatable {
  final String phone;
  final String email;
  final String link;

  const Contacts(
      {required this.phone, required this.email, required this.link});

  @override
  List<Object> get props => [
        phone,
        email,
        link,
      ];
}

class Authentication extends Equatable {
  final Customer? customer;
  final Contacts? contacts;

  const Authentication({required this.customer, required this.contacts});

  @override
  List<Object?> get props => [
        customer,
        contacts,
      ];
}

class ForgetPassword extends Equatable {
  final String support;

  const ForgetPassword(
      {required this.support});

  @override
  List<Object> get props => [
        support,
      ];
}

class Service extends Equatable {
  final int id;
  final String title;
  final String image;
  const Service({required this.id,required this.title,required this.image});

  @override
  List<Object?> get props =>[
    id,
    title,
    image,
  ];
}
class BannerAd extends Equatable {
  final int id;
  final String title;
  final String image;
  const BannerAd({required this.id,required this.title,required this.image});

  @override
  List<Object?> get props =>[
    id,
    title,
    image,
  ];
}

class Store extends Equatable {
  final int id;
  final String title;
  final String image;
  const Store({required this.id,required this.title,required this.image});

  @override
  List<Object?> get props =>[
    id,
    title,
    image,
  ];
}

class DataHome extends Equatable {
  final List<Service>service;
  final List<BannerAd> banner;
  final List<Store> store;
  const DataHome({required this.service,required this.banner,required this.store});

  @override
  List<Object?> get props =>[
    service,
    banner,
    store,
  ];
}
class Home extends Equatable{
  final DataHome data;
  const Home({required this.data});

  @override
  List<Object?> get props => [
    data
  ];
}