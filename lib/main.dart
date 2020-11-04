import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khana_mobile_application/Pages/HomePage.dart';
import 'package:khana_mobile_application/Pages/MainPage.dart';
import 'package:khana_mobile_application/Pages/SignIn.dart';
import 'package:khana_mobile_application/Services/FirebaseServicesAuth.dart';
import 'package:khana_mobile_application/controllers/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'localization/localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
  await pathProvider.getApplicationDocumentsDirectory();
  await Firebase.initializeApp();
  Hive.init(appDocumentDirectory.path);
  //initialize setting controller
  Get.lazyPut<SettingsController>(() => SettingsController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthServices>(
          create: (_) => FirebaseAuthServices(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthServices>().authStateChange,
        )
      ],
      child: GetX<SettingsController>(
        init: SettingsController(),
        builder: (_) {
          var locale = _.lang;
          return GetMaterialApp(
            title: 'Khana Mobile Application',
            debugShowCheckedModeBanner: false,
            theme: SettingsController.themeData(true),
            darkTheme: SettingsController.themeData(false),
            locale: _.locale,
            home: HomeWrapper(),
            translations: MyTranslations(),
            supportedLocales: [
              const Locale('en'),
              const Locale('ar'),
            ],
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        }
      ),
    );
  }
}

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MainPage();
    }
    return SignInPage();
  }
}
