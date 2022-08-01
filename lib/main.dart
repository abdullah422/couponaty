import 'package:couponaty/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/welcom_controller.dart';
import 'screens/splash_screen.dart';
import 'services/api.dart';
var titleTextStyle = TextStyle(fontSize: 22, color: Colors.black);

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color:Colors.blue,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: mainColor),
        ),
      ),
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
