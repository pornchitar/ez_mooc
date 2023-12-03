import 'package:ez_mooc/app/modules/main/controllers/main_controller.dart';
import 'package:ez_mooc/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Kanit'),
          bodyText2: TextStyle(fontFamily: 'Kanit'),
          headline1: TextStyle(fontFamily: 'Kanit'),
          headline2: TextStyle(fontFamily: 'Kanit'),
          headline3: TextStyle(fontFamily: 'Kanit'),
          // Add other styles if needed
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
