import 'package:couponaty/controllers/favourite_controller.dart';
import 'package:couponaty/screens/login_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../contants.dart';
import '../controllers/auth_controller.dart';
import '../controllers/welcom_controller.dart';
import '../models/coupon.dart';
import 'coupons_screen.dart';
import 'logintest.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    // TODO: implement initState
    if (Get.find<AuthController>().isLoggedIn.value) {
      favouriteController.getFCoupons();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('Favourites'),
        ),
        body: Get.find<AuthController>().isLoggedIn.value
            ? favouriteController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: mainColor,
                  ))
                : favouriteController.fCoupons.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/undraw_wishlist_re_m7tv.svg',
                            width: 260,
                            height: 250,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text('You don\'t have any coupon in favourite list'),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.find<WelcomeController>().currentIndex.value = 0;
                                //Get.offAll(() => WelcomeScreen());
                              },
                              child: Text('Explore',style: TextStyle(color:Colors.black,decoration:TextDecoration.underline,),),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return couponItem(
                                  favouriteController.fCoupons[index],index);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: favouriteController.fCoupons.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                          ),
                        ),
                      )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/undraw_security_re_a2rk.svg',
                    width: 260,
                    height: 250,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('You have to login First'),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => MyLogin());
                      },
                      child: Text('login',style: TextStyle(color:Colors.black,decoration:TextDecoration.underline,),),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget couponItem(Coupon coupon,int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height / 4.1,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50))),
                        width: 35,
                        height: 70,
                      ),
                      DottedLine(
                        dashColor: Colors.black54,
                        lineLength: MediaQuery.of(context).size.height / 4.4,
                        direction: Axis.vertical,
                        dashLength: 17,
                        lineThickness: 2,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.35,
            height: MediaQuery.of(context).size.height / 4.1,
            color: Colors.white,
            padding: EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 3.8,
                        child: Image.network(
                          url + coupon.brand.image,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width / 3.8,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                             /* favouriteController
                                  .addOrRemoveFromFavourites(
                                      couponId: coupon.id)
                                  .then((value) {
                                setState((){});
                              });*/
                              favouriteController.removeFromFavourites(index:index,couponId: coupon.id);
                            },
                            padding: EdgeInsets.all(0),
                            icon: CircleAvatar(
                              backgroundColor:
                                  favouriteController.favorites[coupon.id] ==
                                          true
                                      ? mainColor
                                      : Colors.grey,
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share_outlined))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 11,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      coupon.des,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                GetCouponButton(
                  coupon: coupon,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
