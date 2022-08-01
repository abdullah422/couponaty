import 'package:couponaty/contants.dart';
import 'package:couponaty/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../controllers/welcom_controller.dart';

class SplashScreen extends StatelessWidget {

  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -math.pi / 11,
            child: Image.asset('assets/images/coupon.png',height: 140,),
          ),
          SizedBox(height:20),
          Container(
            width: double.infinity,
              child: Center(child: Text('Couponaty',style: TextStyle(fontSize:40,color: Colors.white),))),

          SizedBox(height:35),
          CircularProgressIndicator(color:Colors.white,),
        ],
      ),
    );
  }
}

