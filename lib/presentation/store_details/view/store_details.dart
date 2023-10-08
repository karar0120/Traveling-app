import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:tut_app/presentation/store_details/view_model/store_details_view_model.dart';

import '../../resources/Color_Manger.dart';
import '../../resources/strings_manger.dart';
import '../../resources/values_manger.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({Key? key}) : super(key: key);

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {

 final StoreDetailsViewModel storeDetailsViewModel= instance<StoreDetailsViewModel>();

  _bind(){
    storeDetailsViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<StateFlow>(
        stream:storeDetailsViewModel.getOutputState,
        builder: (context,snapshot)=>snapshot.data?.getScreenWidget(
            context: context,
            contentScreenWidget: _getContentWidget(),
            retryActionFunction: (){
              _bind();
            })??_getContentWidget(),
      ),
    );
  }


 Widget _getContentWidget() {
   return Scaffold(
       backgroundColor: ColorManger.white,
       appBar: AppBar(
         title:  Text(AppString.storeDetails.tr()),
         elevation: AppSize.s0,
         iconTheme: const IconThemeData(
           //back button
           color: ColorManger.white,
         ),
         backgroundColor: ColorManger.primary,
         centerTitle: true,
       ),
       body: Container(
         constraints: const BoxConstraints.expand(),
         color: ColorManger.white,
         child: SingleChildScrollView(
           child: StreamBuilder<StoreDetailsViewObject>(
             stream:  storeDetailsViewModel.outputStoreDetailsData,
             builder: (context, snapshot) {
               return _getItems(snapshot.data);
             },
           ),
         ),
       ));
 }

 Widget _getItems(StoreDetailsViewObject? storeDetails) {
   if (storeDetails != null) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Center(
             child: Image.network(
               storeDetails.image,
               fit: BoxFit.cover,
               width: double.infinity,
               height: 250,
             )),
         _getSection(AppString.details.tr()),
         _getInfoText(storeDetails.details),
         _getSection(AppString.services.tr()),
         _getInfoText(storeDetails.service),
         _getSection(AppString.about.tr()),
         _getInfoText(storeDetails.about)
       ],
     );
   } else {
     return Container();
   }
 }

 Widget _getSection(String title) {
   return Padding(
       padding: const EdgeInsets.only(
           top: AppPadding.p12,
           left: AppPadding.p12,
           right: AppPadding.p12,
           bottom: AppPadding.p2),
       child: Text(title, style: Theme.of(context).textTheme.titleMedium));
 }

 Widget _getInfoText(String info) {
   return Padding(
     padding: const EdgeInsets.all(AppSize.s12),
     child: Text(info, style: Theme.of(context).textTheme.bodySmall),
   );
 }
  @override
  void dispose() {
    super.dispose();
    storeDetailsViewModel.dispose();
  }
}

