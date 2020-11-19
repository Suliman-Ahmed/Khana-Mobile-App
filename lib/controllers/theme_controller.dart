// we use provider to manage the app state

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Provider finished
class SettingsController extends GetxController {
  ///to use SettingsController.to instead Get.find<SettingsController>()
  static SettingsController get to => Get.find();

  @override
  onInit() {
    getThemeModeFromDataBase();
    getlocaleFromDataBase();
    getPrefColorFromDataBase();
    createFile();
  }

  Box settings;
  final prefColor = '0xFF3589E0'.obs;
  final _themeMode = ThemeMode.system.obs;
  final _locale = Locale('en').obs;

  Locale get locale => _locale.value;

  bool get lang => _locale.value == Locale('ar');

  bool get isAndroid => GetPlatform.isAndroid;

  Color get PrimeColor => Color(0xFF3589E0);

  ThemeMode get themeMode => _themeMode.value;

  Future<void> setThemeMode(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    _themeMode.value = themeMode;
    update();
    settings = await Hive.openBox('settings');
    await settings.put('theme', themeMode.toString().split('.')[1]);
  }

  getThemeModeFromDataBase() async {
    ThemeMode themeMode;
    settings = await Hive.openBox('settings');
    String themeText = settings.get('theme') ?? 'system';
    try {
      if (themeText == 'system') {
        themeMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;
      } else {
        themeMode =
            ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
      }
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }

  Future<void> setLocale(Locale newLocale) async {
    Get.updateLocale(newLocale);
    _locale.value = newLocale;
    update();
    settings = await Hive.openBox('settings');
    await settings.put('languageCode', newLocale.languageCode);
  }

  getlocaleFromDataBase() async {
    Locale locale;
    settings = await Hive.openBox('settings');
    String languageCode =
        settings.get('languageCode') ?? Get.locale.languageCode;
    try {
      locale = Locale(languageCode);
    } catch (e) {
      locale = Locale('en');
    }
    setLocale(locale);
  }

  Future<void> setPrefColor(String newPrefColor) async {
    prefColor.value = newPrefColor;
    settings = await Hive.openBox('settings');
    await settings.put('prefrencesColor', newPrefColor);
  }

  getPrefColorFromDataBase() async {
    String prefColor;
    settings = await Hive.openBox('settings');
    String dbPrefColor = settings.get('prefrencesColor') ??
        (Get.isDarkMode ? '0xFF76DC58' : '0xFF000000');
    try {
      prefColor = dbPrefColor;
    } catch (e) {
      prefColor = '0xFF76DC58';
    }
    setPrefColor(prefColor);
  }

  void createFile() async{
    await Permission.storage.request();

    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");
    if (!file.existsSync()) {
      file.create();
      String data = '{\"data\": [],\"list\": []}';
      file.writeAsString(data);
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Storage Functions
  //////////////////////////////////////////////////////////////////////////////
  /// Add
  /// Add Item
  void addItemToStorage(items) async {
    await Permission.storage.request();

    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");

    if (!file.existsSync()) {
      file.create();
      String data = '{\"data\": [],\"list\": []}';
      file.writeAsString(data);
    }

    try {
      String data = await file.readAsString();
      if (data == '{\"data\": [],\"list\": []}') {
        data = data.replaceFirst(']', '${items.toString()}]');
      } else
        data = data.replaceFirst(']', ',${items.toString()}]');

      file.writeAsString(data);
      // print(data);
    } catch (e) {
      print('can not write $e');
    }
  }

  /// Add Item
  void addListItemToStorage(items) async {
    await Permission.storage.request();

    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");

    if (!file.existsSync()) {
      file.create();
      String data = '{\"data\": [],\"list\": []}';
      file.writeAsString(data);
    }

    try {
      String data = await file.readAsString();
      if (data.contains('\"list\": []}')) {
        data = data.replaceFirst(']', '${items.toString()}]', data.length - 2);
      } else
        data = data.replaceFirst(']', ',${items.toString()}]', data.length - 2);

      file.writeAsString(data);
      // print(data);
    } catch (e) {
      print('can not write $e');
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Read
  /// Read Item
  Future<List<dynamic>> readItemsFromStorage() async {
    await Permission.storage.request();
    List items = List();
    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");
    try {
      file.open(mode: FileMode.read);
      String data = await file.readAsString();
      data = data.replaceFirst('[,', '[');
      var decodedJson = json.decode(data)['data'];

      items = decodedJson != null ? List.from(decodedJson) : null;
    } catch (e) {
      print('Can not Read $e');
      items = [];
    }
    return items;
  }

  /// Read List
  Future<List<dynamic>> readListItemsFromStorage() async {
    await Permission.storage.request();
    List items = List();
    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");
    try {
      String data = await file.readAsString();
      data.replaceAll('[,', '[');
      var decodedJson = json.decode(data)['list'];

      items = decodedJson != null ? List.from(decodedJson) : null;
    } catch (e) {
      print('Can not Read $e');
      items = [];
    }
    return items;
  }

  /// Delete Item
  void cleanData() async {
    await Permission.storage.request();
    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");
    file.writeAsString('{\"data\": [],\"list\": []}');
  }

  /// Delete List
  void cleanList() async {
    await Permission.storage.request();
    Directory path = await getApplicationDocumentsDirectory();
    File file = File(path.path + "/khana_storage.json");
    String data = await file.readAsString();
    String startText = data.substring(0, data.indexOf('list'));
    startText += 'list\": []}';
    // data.replaceFirst('[', '[', data.indexOf('list'));
    file.writeAsString(startText);
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Common Function
  void showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Theme
  static ThemeData themeData(bool isLightTheme) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.grey,
      primaryColor: Color(0xFF3589E0),
      brightness: Brightness.light,
      backgroundColor: Color(0xFFFFFFFF),
      scaffoldBackgroundColor: Color(0xFFFFFFFF) /* White */,
      canvasColor: Colors.white,
      cardColor: Colors.white,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFF9F9F9),
        type: BottomNavigationBarType.fixed,
        elevation: 2,
        unselectedItemColor: const Color(0xffC5C3E3),
      ),
      appBarTheme: AppBarTheme(color: Color(0xFFF9F9F9), centerTitle: true),
    );
  }
}
