import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:tut_app/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/Strings_Manger.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';

import '../../../../../domain/model/model.dart';
import '../../../../resources/Color_Manger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: StreamBuilder(
        stream: _homeViewModel.getOutputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidget(),
                retryActionFunction: () {
                  _homeViewModel.start();
                }) ??
            _getContentWidget(),
      )),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
        stream: _homeViewModel.outputHomeData,
        builder: (context,snapshot){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBannerWidget(banner: snapshot.data?.banners),
              _getSection(title: AppString.service),
              _getServicesWidget(services: snapshot.data?.services),
              _getSection(title: AppString.store),
              _getStoresWidget(store: snapshot.data?.stores),
            ],
          );
        });
  }


  Widget _getBannerWidget({required List<BannerAd>? banner}) {
    if (banner != null) {
      return CarouselSlider(
          items: banner.map((banner) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                elevation: AppSize.s1_5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: const BorderSide(
                        color: ColorManger.primary, width: AppSize.s1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  child: Image.network(
                    banner.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
          ));
    } else {
      return Container();
    }
  }

  Widget _getSection({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }


  Widget _getServicesWidget({required List<Service>? services}) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
        ),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((services) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: const BorderSide(
                              color: ColorManger.white, width: AppSize.s1)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              services.image,
                              fit: BoxFit.cover,
                              width: AppSize.s120,
                              height: AppSize.s120,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  services.title,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }



  Widget _getStoresWidget({required List<Store>?store}){
    if (store !=null){
      return Padding(padding: const EdgeInsets.only(
        left: AppPadding.p12,
        right: AppPadding.p12,
        top: AppPadding.p12
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
              crossAxisCount: AppSize.s2.toInt(),
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
          physics: const ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(store.length, (index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                child: Card(
                  elevation: AppSize.s4,
                  child: Image.network(store[index].image,fit: BoxFit.cover,),
                ),
              );
            }),
          )
        ],
      ),
      );
    }else {
      return Container();
    }
  }
  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }
}
