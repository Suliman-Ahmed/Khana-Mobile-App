import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/Pages/AddItem.dart';
import 'package:khana_mobile_application/Pages/AddList.dart';
import 'package:khana_mobile_application/Pages/HomePage.dart';
import 'package:khana_mobile_application/Pages/ShowItem.dart';
import 'package:khana_mobile_application/Pages/ShowList.dart';
import 'package:khana_mobile_application/UI/khana_icons_icons.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(KhanaIcons.analisis),title: Text('')),
    BottomNavigationBarItem(icon: Icon(KhanaIcons.add),title: Text('')),
    BottomNavigationBarItem(icon: Icon(KhanaIcons.list),title: Text('')),
    BottomNavigationBarItem(icon: Icon(KhanaIcons.showitem),title: Text('')),
    BottomNavigationBarItem(icon: Icon(KhanaIcons.showList),title: Text('')),
  ];

  int selectedIndex = 0;

  List<Widget> pages = [
    HomePage(),
    AddItemPage(),
    AddListPage(),
    ShowItemsPage(),
    ShowListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s) {
        bool lang = s.lang;
        return Scaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomItems,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}

