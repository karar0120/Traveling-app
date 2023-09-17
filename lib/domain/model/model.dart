import 'package:equatable/equatable.dart';

class SliderObject  extends Equatable{
  final String title;
  final String subTitle;
  final String image;

 const SliderObject(this.title, this.subTitle, this.image);

  @override
  List<Object> get props => [
    title,
    subTitle,
    image
  ];
}

class SliderViewObject extends Equatable {
  final SliderObject sliderObject;
  final int numOfSliders;
  final int currentIndex;

 const SliderViewObject(this.sliderObject,this.numOfSliders,this.currentIndex);

  @override
  List<Object?> get props => [
    sliderObject,
    numOfSliders,
    currentIndex,
  ];

}



class Customer extends Equatable{
 final String id;
 final String name;
 final int numOfNotification;
 const Customer({required this.id,required this.name,required this.numOfNotification});


  @override
  List<Object> get props => [
    id,
    name,
    numOfNotification,
  ];


}



class Contacts extends Equatable{

  final String phone;
  final String email;
  final String link;
  const Contacts({required this.phone,required this.email,required this.link});

  @override
  List<Object> get props => [
    phone,
    email,
    link,
  ];


}



class Authentication extends Equatable{

  final Customer? customer;
  final Contacts? contacts;

  const Authentication({required this.customer,required this.contacts});

  @override
  List<Object?> get props => [
    customer,
    contacts,
  ];


}

