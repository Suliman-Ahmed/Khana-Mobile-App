import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';

class ShowListPage extends StatefulWidget {
  @override
  _ShowListPageState createState() => _ShowListPageState();
}

class _ShowListPageState extends State<ShowListPage> {
  List items = [];

  SettingsController settingsController = SettingsController();

  List searchedItem = [];

  fetchData() async {
    items = await settingsController.readListItemsFromStorage();
    searchedItem = await settingsController.readItemsFromStorage();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s) {
        bool lang = s.lang;
        return Scaffold(
            appBar: appbar('Show List', context),
            body: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, snap) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: items.length ?? 1,
                  itemBuilder: (BuildContext context, int index) {
                    return CardBlock(index);
                  },
                );
              },
            ));
      },
    );
  }

  Widget CardBlock(index) {
    return Container(
      margin: EdgeInsets.only(top: index == 0 ? 30 : 15, right: 20, left: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: CustomColors.cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        ////////////////////////////////////////////////////////////////////////
        /// Name, location and price
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              items[index]['name'] + ', ' + items[index]['location'],
              style: TextStyle(
                  color: CustomColors.black2, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${items[index]['price']} \$',
              style: TextStyle(color: CustomColors.darkGray, fontSize: 17),
            ),
          ],
        ),
        ////////////////////////////////////////////////////////////////////////
        /// ID and date
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(items[index]['id'],
                style: TextStyle(color: CustomColors.black2)),
            SizedBox(height: 20),
            Text(items[index]['date'],
                style: TextStyle(color: CustomColors.darkGray)),
          ],
        ),
        ////////////////////////////////////////////////////////////////////////
        /// Edit pin
        trailing: Container(
          width: 25,
          height: 25,
          child: SvgPicture.asset('assets/img/edit_pin.svg'),
        ),
      ),
    );
  }
}
