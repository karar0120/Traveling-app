import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/model/model.dart';
import 'package:tut_app/domain/use_case/home_use_case.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_imp.dart';

class HomeViewModel extends BaseViewModel implements HomeViewModelInput,HomeViewModelOutput{
 final StreamController _dataStreamController = BehaviorSubject<HomeViewObject>();


 GetHomeDataUseCase getHomeDataUseCase ;

  HomeViewModel({required this.getHomeDataUseCase});


  @override
  void start() {
   _getHomeData();
  }

  _getHomeData()async{
   inputState.add(
       LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
   (await getHomeDataUseCase.execute(Void))
       .fold((failure) {
    inputState.add(ErrorState(
        stateRendererType: StateRendererType.fullScreenErrorState,
        message: failure.message!));
   }, (homeObject) {
    inputState.add(ContentState());
    _dataStreamController.add(HomeViewObject(homeObject.data.store,
        homeObject.data.service,
        homeObject.data.banner));

   });

  }

  @override
  void dispose() {
   _dataStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData => _dataStreamController.stream.map((data) => data);

}

abstract class HomeViewModelInput {

 Sink get inputHomeData;

}

abstract class HomeViewModelOutput {
Stream <HomeViewObject> get outputHomeData;
}
class HomeViewObject {
 List<Store> stores;
 List<Service> services;
 List<BannerAd> banners;

 HomeViewObject(this.stores, this.services, this.banners);
}
