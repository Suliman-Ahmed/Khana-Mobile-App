// we use provider to manage the app state

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// Provider finished
class SettingsController extends GetxController {
  ///to use SettingsController.to instead Get.find<SettingsController>()
  static SettingsController get to => Get.find();

  @override
  onInit() {
    getThemeModeFromDataBase();
    getlocaleFromDataBase();
    getPrefColorFromDataBase();
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

  //////////////////////////////////////////////////////////////////////////////
  /// Firebase Function

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
      appBarTheme: AppBarTheme(color: Color(0xFFF9F9F9),centerTitle: true),
    );
  }
}
