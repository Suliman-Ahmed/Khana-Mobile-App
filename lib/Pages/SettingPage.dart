import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/Services/FirebaseServicesAuth.dart';
import 'package:khana_mobile_application/UI/CustomColors.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (s){
        bool lang = s.lang;
        return Scaffold(
          appBar: appbar('Setting',context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                ////////////////////////////////////////////////////////////////
                /// Email
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFE2F8FE).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                        hintText: 'qzwini@khana.org'),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                /// Create Database Button
                Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  decoration: BoxDecoration(
                      color: Color(0xFF43A0E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      // TODO: Create Button
                    },
                    child: Text(
                      'create a database to switch',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                /// Create Database Button
                Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF43A0E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      // TODO: Create Button
                    },
                    child: Text(
                      'database recovery',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                /// SignOut
                Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                  decoration: BoxDecoration(
                      color: CustomColors.whiteRed,
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () {
                      context.read<FirebaseAuthServices>().signOut();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'sign out'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ]
            ),
          ),
        );
      },
    );
  }
}
