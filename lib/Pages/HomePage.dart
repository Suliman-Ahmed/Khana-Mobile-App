import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_mobile_application/Services/FirebaseServicesAuth.dart';
import 'package:khana_mobile_application/UI/khana_icons_icons.dart';
import 'package:khana_mobile_application/Widgets/appbar.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
        init: SettingsController(),
        builder: (s) {
          bool lang = s.lang;
          return Scaffold(
            appBar: appbar('Analisis',context),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(height: 30),
                ////////////////////////////////////////////////////////////////
                /// Items
                CardBlock(
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    // Leading
                    leading: Container(
                        width: 70,
                        height: 70,
                        child: SvgPicture.asset('assets/img/items.svg')),
                    // Title
                    title: Text('Items'),
                    // subtitle
                    subtitle: Text('Oct 1, Nov 1'),
                    // Trailing
                    trailing: Text(
                      '300 item',
                      style: TextStyle(color: s.PrimeColor),
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                /// money
                CardBlock(
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    // Leading
                    leading: Container(
                        width: 70,
                        height: 70,
                        child: SvgPicture.asset('assets/img/money.svg')),
                    // Title
                    title: Text('Money'),
                    // subtitle
                    subtitle: Text('Oct 1, Nov 1'),
                    // Trailing
                    trailing: Text(
                      '\$ 3,000',
                      style: TextStyle(color: s.PrimeColor),
                    ),
                  ),
                ),
                ////////////////////////////////////////////////////////////////
                /// damage
                CardBlock(
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    // Leading
                    leading: Container(
                        width: 70,
                        height: 70,
                        child: SvgPicture.asset('assets/img/damage.svg')),
                    // Title
                    title: Text('Damage'),
                    // subtitle
                    subtitle: Text('Oct 1, Nov 1'),
                    // Trailing
                    trailing: Text(
                      '- 60',
                      style: TextStyle(color: s.PrimeColor),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                ////////////////////////////////////////////////////////////////
                /// Top Items
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    "Top Items",
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  margin: EdgeInsets.only(
                      left: lang ? 0 : 20, right: lang ? 20 : 0, top: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return listItemBlock();
                    },
                  ),
                ),
                SizedBox(height: 35),
                ////////////////////////////////////////////////////////////////
                /// Out of stock
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Text(
                    "Out of stock",
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  margin: EdgeInsets.only(
                      left: lang ? 0 : 20, right: lang ? 20 : 0, top: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return listItemBlock();
                    },
                  ),
                ),
                SizedBox(height: 30)
              ]),
            ),
          );
        });
  }

  Container CardBlock(child) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          child: child,
        ));
  }
}

class listItemBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage('assets/img/skeleton_flash.jpg'),
              fit: BoxFit.cover)),
      // child: Image.asset('assets/img/skeleton_flash.jpg',fit: BoxFit.cover),
    );
  }
}
