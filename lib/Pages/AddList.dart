import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';

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
                        Expanded(
                            flex: 4,
                            child: itemTextField(
                                hint: 'item ${index + 1}',
                                controller: itemsID.length == 0
                                    ? _firstID
                                    : itemsID[index])),
                        Expanded(
                          child: CustomButton(
                              icon: Feather.minus,
                              color: CustomColors.red,
                              function: () {
                                setState(() {
                                  if (index > 0) {
                                    itemsID.removeAt(index);
                                  }
                                });
                              }),
                        ),
                        (itemsID.length == 0)
                            ? Expanded(
                                child: CustomButton(
                                    icon: Feather.plus,
                                    color: CustomColors.green,
                                    function: () {
                                      setState(() {
                                        print(
                                            "Text = (${itemsID.length == 0 ? _firstID.text : itemsID[index].text})");
                                        TextEditingController item =
                                            TextEditingController();
                                        itemsID.add(item);
                                      });
                                    }),
                              )
                            : SizedBox(),
                        (index == itemsID.length-1)
                            ? Expanded(
                                child: CustomButton(
                                    icon: Feather.plus,
                                    color: CustomColors.green,
                                    function: () {
                                      setState(() {
                                        print(
                                            "Text = (${itemsID.length == 0 ? _firstID.text : itemsID[index].text})");
                                        TextEditingController item =
                                            TextEditingController();
                                        itemsID.add(item);
                                      });
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
                  onPressed: () => print("Add List"),
                  child: Text(
                    'Add List',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          ),
        );
      },
    );
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
