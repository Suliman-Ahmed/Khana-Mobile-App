import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController _ItemID = TextEditingController();
  TextEditingController _ItemName = TextEditingController();
  TextEditingController _ItemDescription = TextEditingController();
  int numberOfItem = 1;
  int priceOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s) {
        bool lang = s.lang;
        return Scaffold(
          appBar: appbar('Add Item',context),
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
                  "ID",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: '1345', controller: _ItemID),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Name
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Name",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(hint: 'Example', controller: _ItemName),
              SizedBox(height: 20),
              ////////////////////////////////////////////////////////////////
              /// Item Description
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Information",
                  textAlign: TextAlign.start,
                ),
              ),
              textField(
                  hint: 'Some description about item',
                  controller: _ItemDescription),
              SizedBox(height: 20),
              //////////////////////////////////////////////////////////////////
              Row(children: [
                /// Number Of Items
                Expanded(
                    child: Column(
                  children: [
                    Text("Number of Items", textAlign: TextAlign.center),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                                icon: Feather.minus,
                                color: Color(0xFFED6663),
                                function: () {
                                  // TODO: Minus Function
                                  print('minus');
                                }),
                            Text("$numberOfItem"),
                            CustomButton(
                                icon: Feather.plus,
                                color: Color(0xFF2EC1AC),
                                function: () {
                                  // TODO: Minus Function
                                  print('plus');
                                }),
                          ]),
                    )
                  ],
                )),

                /// Price in Dollar
                Expanded(
                    child: Column(
                  children: [
                    Text("Price in dollar", textAlign: TextAlign.center),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomButton(
                                icon: Feather.minus,
                                color: Color(0xFFED6663),
                                function: () {
                                  // TODO: Minus Function
                                  print('minus');
                                }),
                            Text("$priceOfItem\$"),
                            CustomButton(
                                icon: Feather.plus,
                                color: Color(0xFF2EC1AC),
                                function: () {
                                  // TODO: Minus Function
                                  print('plus');
                                }),
                          ]),
                    )
                  ],
                )),
              ]),
              SizedBox(height: 30),
              //////////////////////////////////////////////////////////////////
              /// Select Image
              Text("Upload Image", textAlign: TextAlign.center),
              SizedBox(height: 15),
              InkWell(
                onTap: (){
                  // TODO: Upload image
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: SvgPicture.asset("assets/img/upload_image.svg"),
                ),
              ),
              //////////////////////////////////////////////////////////////////
              /// Add Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                decoration: BoxDecoration(
                  color: CustomColors.blue2,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: FlatButton(
                  onPressed: () => print("Add Item"),
                  child: Text('Add Item',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
          onPressed: () => function()),
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
}
