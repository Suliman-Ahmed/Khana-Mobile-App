import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddListPage extends StatefulWidget {
  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  TextEditingController _listID = TextEditingController();
  TextEditingController _listName = TextEditingController();
  TextEditingController _listLocation = TextEditingController();
  TextEditingController _firstID = TextEditingController();

  List<TextEditingController> itemsID = [];

  @override
  void initState() {
    super.initState();
    itemsID.add(_firstID);
  }

  int numberOfItem = 1;
  int priceOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s) {
        bool lang = s.lang;
        return Scaffold(
          appBar: appbar('Crate List', context),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              /// Clear Button
              Center(
                child: CustomButton(
                    icon: Feather.x,
                    color: Color(0xFF999999),
                    function: () {
                      // TODO: Clear Function
                      print("Clear Function");
                    }),
              ),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item ID
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "ID of List",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: '1345', controller: _listID),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Name
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Name of customer",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: 'Example', controller: _listName),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Description
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "location",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: 'Iraq, Baghdad', controller: _listLocation),
              SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemsID.length == 0 ? 1 : itemsID.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ////////////////////////////////////////////////////////
                        /// Text Field
                        Expanded(
                            flex: 4,
                            child: itemTextField(
                                hint: 'item ${index + 1}',
                                controller: itemsID.length == 0
                                    ? _firstID
                                    : itemsID[index])),
                        ////////////////////////////////////////////////////////
                        /// Minus Button
                        Expanded(
                          child: CustomButton(
                              icon: Feather.minus,
                              color: CustomColors.red,
                              function: () {
                                setState(() {
                                  if (index > -1 && itemsID.length != 0) {
                                    itemsID.removeAt(index);
                                  }
                                });
                              }),
                        ),
                        ////////////////////////////////////////////////////////
                        /// Plus Button
                        // (itemsID.length == 0)
                        //     ? Expanded(
                        //         child: CustomButton(
                        //             icon: Feather.plus,
                        //             color: CustomColors.green,
                        //             function: () {
                        //               setState(() {
                        //                 print(
                        //                     "Text = (${itemsID.length == 0 ? _firstID.text : itemsID[index].text})");
                        //                 TextEditingController item =
                        //                     TextEditingController();
                        //                 itemsID.add(itemsID.length == 0
                        //                     ? _firstID
                        //                     : item);
                        //               });
                        //             }),
                        //       )
                        //     : SizedBox(),
                        (index == itemsID.length - 1)
                            ? Expanded(
                                child: CustomButton(
                                    icon: Feather.plus,
                                    color: CustomColors.green,
                                    function: () {
                                      addField(s, index);
                                    }),
                              )
                            : SizedBox(),
                      ]);
                },
              ),
              SizedBox(height: 30),
              //////////////////////////////////////////////////////////////////
              /// Add Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                decoration: BoxDecoration(
                    color: CustomColors.blue2,
                    borderRadius: BorderRadius.circular(10)),
                child: FlatButton(
                  /// TODO: Add List Function
                  onPressed: () => addItemMethod(s),
                  child: Text(
                    'Add List',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // //////////////////////////////////////////////////////////////////
              // /// Read Button
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: CustomColors.green,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: FlatButton(
              //     onPressed: () => s.readListItemsFromStorage(),
              //     child: Text(
              //       'Read List',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // //////////////////////////////////////////////////////////////////
              // /// Delete Button
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       color: CustomColors.red,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: FlatButton(
              //     onPressed: () => s.cleanList(),
              //     child: Text(
              //       'Delete List',
              //       style: TextStyle(
              //           color: Colors.white, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
            ]),
          ),
        );
      },
    );
  }

  void addField(s, index) async {
    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");

    try {
      String data = await file.readAsString();
      data.replaceAll('[,', '[');
      if (data.contains(itemsID[index].text) && itemsID[index].text != '') {
        setState(() {
          print(
              "Text = (${itemsID.length == 0 ? _firstID.text : itemsID[index].text})");
          TextEditingController item = TextEditingController();
          itemsID.add(item);
        });
      } else {
        s.showToast("There is no such this ID");
      }
    } catch (e) {}
  }

  void addItemMethod(s) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    await Permission.storage.request();
    List<String> itemsIDList = [];

    List ITEMS = await s.readItemsFromStorage();

    // var it = ITEMS.firstWhere((element) => element['id'] == '1112');
    int finalPrice = 0;

    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");

    if (!file.existsSync()) {
      file.create();
      String data = '{\"data\": [],\"list\": []}';
      file.writeAsString(data);
    }

    try {
      String data = await file.readAsString();
      data.replaceAll('[,', '[');
      var decodedJson = json.decode(data)['data'];
      if (!data.contains(_listID.text)) {
        for (int i = 0; i < itemsID.length; i++) {
          String decodeData = decodedJson.toString();
          if (decodeData.contains(itemsID[i].text)) {
            for (var i in itemsID) {
              itemsIDList.add(i.text);
            }
          }
        }

        itemsIDList = itemsIDList.toSet().toList();

        var item;
        itemsIDList.forEach((it) {
          item = ITEMS.firstWhere((e) => e['id'] == it);
          finalPrice += item['price'];
        });
        Map items = {
          '\"id\"': "\"${_listID.text.trim()}\"",
          '\"name\"': "\"${_listName.text.trim()}\"",
          '\"location\"': "\"${_listLocation.text.trim()}\"",
          '\"date\"': "\"$formatted\"",
          '\"price\"': "\"$finalPrice\"",
          '\"items\"': '\"${itemsIDList.toString()}\"',
        };
        // print(items);
        s.addListItemToStorage(items);
      } else {
        s.showToast('invalid ID');
      }
    } catch (e) {
      print('can not write $e');
    }
  }

  CircleAvatar CustomButton({IconData icon, Color color, function}) {
    return CircleAvatar(
      backgroundColor: color,
      child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: () {
            function();
          }),
    );
  }

  Container textField({String hint, TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFFE2F8FE).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: InputBorder.none,
            hintText: hint),
      ),
    );
  }

  Container itemTextField({String hint, TextEditingController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFFE2F8FE).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            border: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}
