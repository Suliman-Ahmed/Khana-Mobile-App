import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:khana_mobile_application/Pages/SettingPage.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';

AppBar appbar(title,context) {
  SettingsController settingsController = SettingsController();
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: settingsController.PrimeColor),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF43A0E7)
    ),
    actions: [
      title != "Setting" ? IconButton(
          icon: Icon(Feather.settings, color: Color(0xFF43A0E7)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingPage()));
          }): SizedBox()
    ],
  );
}