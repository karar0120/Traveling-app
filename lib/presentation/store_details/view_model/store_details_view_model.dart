import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';

import '../../../domain/use_case/store_detials_use_case.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_imp.dart';


class StoreDetailsViewModel extends BaseViewModel implements StoreDetailsViewModelInput,
    StoreDetailsViewModelOutput{
  final StreamController _dataStreamController = BehaviorSubject<StoreDetailsViewObject>();


  StoreDetailsUseCase storeDetailsUseCase ;

  StoreDetailsViewModel({required this.storeDetailsUseCase});


  @override
  void start() {
    _getStoreDetailsData();
  }

  _getStoreDetailsData()async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailsUseCase.execute(Void))
        .fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message!));
    }, (storeDetails) {
      inputState.add(ContentState());
      _dataStreamController.add(
          StoreDetailsViewObject(
              storeDetails.image,
              storeDetails.details,
              storeDetails.title,
              storeDetails.about,
              storeDetails.services,
          ));

    });

  }

  @override
  void dispose() {
    _dataStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputStoreDetailsData => _dataStreamController.sink;

  @override
  Stream<StoreDetailsViewObject> get outputStoreDetailsData => _dataStreamController.stream.map((data) => data);

}

abstract class StoreDetailsViewModelInput {

  Sink get inputStoreDetailsData;

}

abstract class StoreDetailsViewModelOutput {
  Stream <StoreDetailsViewObject> get outputStoreDetailsData;
}
class StoreDetailsViewObject {
  final String image;
  final String details;
  final String title;
  final String service;
  final String about;


  StoreDetailsViewObject(this.image, this.details, this.title,this.about,this.service);
}
