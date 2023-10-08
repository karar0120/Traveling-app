import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/presentation/main/pages/home/view/home_page.dart';
import 'package:tut_app/presentation/main/pages/notification/view/notification_page.dart';
import 'package:tut_app/presentation/main/pages/search/view/search_page.dart';
import 'package:tut_app/presentation/main/pages/settings/view/settings_page.dart';
import 'package:tut_app/presentation/resources/Color_Manger.dart';
import 'package:tut_app/presentation/resources/values_manger.dart';
import '../resources/strings_manger.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _page=[
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];
  final List<String> _titles=[
    AppString.home.tr(),
    AppString.search.tr(),
    AppString.notifications.tr(),
    AppString.settings.tr(),
  ];
 String _title = AppString.home.tr();
int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: _page[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManger.lightGray,spreadRadius: AppSize.s1)
          ]
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManger.primary,
          unselectedItemColor: ColorManger.gray,
          currentIndex: _currentIndex,
          onTap: onTap,
          items:  [
            BottomNavigationBarItem(icon: const Icon(Icons.home_outlined),label: AppString.home.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.search),label: AppString.search.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.notifications),label: AppString.notifications.tr()),
            BottomNavigationBarItem(icon: const Icon(Icons.settings),label: AppString.settings.tr()),
          ],
        ),
      ),
    );
  }
  onTap(int index){
    setState(() {
      _currentIndex=index;
      _title=_titles[index];
    });
  }
}
