import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/welcom_controller.dart';
import '../custom_dialog.dart';

class WelcomeScreen extends StatelessWidget {
  final welcomeController = Get.put(WelcomeController(), permanent: true);

  // WelcomeController welcomeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>showExitPopup(context),
      child: Obx(() {
        return Scaffold(
          body: SafeArea(
              child: welcomeController.screens[welcomeController.currentIndex.value]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: welcomeController.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
            unselectedLabelStyle: TextStyle(fontSize: 10.0),
            selectedLabelStyle: TextStyle(fontSize: 15.0),
            selectedFontSize: 12.0,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/coupons.png",
                    width: 35,
                    height: 35,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/brands.png",
                    width: 35,
                    height: 30,
                    //color: Colors.grey,
                  ),
                  label: 'Brand'),
              BottomNavigationBarItem(
                label: 'My Favorites',
                icon: Image.asset(
                  "assets/images/favorite.png",
                  width: 35,
                  height: 30,
                  //color: Colors.grey,
                ),
              ),
              BottomNavigationBarItem(
                label: 'More',
                icon: Image.asset(
                  "assets/images/more1.png",
                  width: 35,
                  height: 30,
                  //color: Colors.grey,
                ),
              ),
            ],
            onTap: (index) {
              welcomeController.currentIndex.value = index;
            },
          ),
        );
      }),
    );
  }
}
