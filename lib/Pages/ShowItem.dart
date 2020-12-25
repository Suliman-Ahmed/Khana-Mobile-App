import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/Pages/AddItem.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShowItemsPage extends StatefulWidget {
  @override
  _ShowItemsPageState createState() => _ShowItemsPageState();
}

class _ShowItemsPageState extends State<ShowItemsPage> {
  List items = [];

  SettingsController settingsController = SettingsController();

  fetchData() async {
    items = await settingsController.readItemsFromStorage();
    setState(() {});
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
        fetchData();
        bool lang = s.lang;
        return Scaffold(
            appBar: appbar('Show Items', context),
            body: FutureBuilder(
              future: fetchData(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (!(snap.data == null)) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    fetchData();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardBlock(index);
                    },
                  ),
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
        /// Image
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5000),
              image: DecorationImage(
                  image: (items[index]['image'] != '')
                      ? FileImage(File(items[index]['image']))
                      : AssetImage('assets/img/skeleton_flash.jpg'),
                  fit: BoxFit.cover)),
        ),
        ////////////////////////////////////////////////////////////////////////
        /// name, id, description and num of remaining items
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name and ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(items[index]['name'],
                    style: TextStyle(
                        color: CustomColors.black2,
                        fontWeight: FontWeight.bold)),
                Text(items[index]['id'].toString(),
                    style: TextStyle(color: CustomColors.black2)),
              ],
            ),
            SizedBox(height: 5),

            /// Description
            Text(items[index]['des'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: CustomColors.darkGray)),
            SizedBox(height: 5),
            ////////////////////////////////////////////////////////////////////
            /// Indicator
            LinearPercentIndicator(
              trailing: Text(
                  '${items[index]['numOfLeftPieces']} / ${items[index]['numOfPieces']}'),
              lineHeight: 10,
              percent:
                  items[index]['numOfLeftPieces'] / items[index]['numOfPieces'],
              backgroundColor: CustomColors.blue2,
              progressColor: CustomColors.white,
            ),
          ],
        ),
        ////////////////////////////////////////////////////////////////////////
        /// Edit pin
        trailing: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => AddItemPage(editItem: items[index])));
          },
          child: Container(
            width: 25,
            height: 25,
            child: SvgPicture.asset('assets/img/edit_pin.svg'),
          ),
        ),
      ),
    );
  }
}
