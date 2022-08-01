import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:couponaty/controllers/welcom_controller.dart';
import 'package:couponaty/models/brand.dart';
import 'package:couponaty/models/coupon.dart';
import 'package:couponaty/screens/coupons_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import '../contants.dart';
import '../controllers/home_controller.dart';
import '../custom_dialog.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=>showExitPopup(context),
      child: Obx(
        () => Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: homeController.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: HexColor('#79BD9A'),
                    ),
                  )
                : Stack(
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: 0,
                        child: Container(
                          height: 300,
                          child: Column(
                            children: [
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(10.sp),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      mainColor,
                                      HexColor('#79BD9A').withOpacity(.9),
                                      HexColor('#79BD9A').withOpacity(.8),
                                      HexColor('#79BD9A').withOpacity(.6),
                                      HexColor('#79BD9A').withOpacity(.5),
                                      Colors.grey[300]!.withOpacity(0.6),
                                      // Colors.white.withOpacity(),
                                    ])),
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                //  color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 7,
                              margin: EdgeInsets.only(left: 7, right: 7, top: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.0),
                              ),
                              //color: HexColor('3B8686'),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 19,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    'Couponaty',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 37,
                            ),
                            Text(
                              '  Top Stores',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: Text(
                                      'Show All ...  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    onTap: () {
                                      Get.find<WelcomeController>()
                                          .currentIndex
                                          .value = 1;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Column(
                                children: [
                                  Container(
                                    height: 100,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return BrandItem(
                                            homeController.brands[index]);
                                      },
                                      itemCount: homeController.brands.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 5,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: backgroundColor,
                                ),
                                child: CarouselSlider(
                                  items: homeController.banners
                                      .map((e) => ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: progressIndicatorColor,
                                                  ),
                                                ),
                                                FadeInImage.memoryNetwork(
                                                  placeholder: kTransparentImage,
                                                  image: url + e.image,
                                                  fit: BoxFit.fill,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                                  width: double.infinity,
                                                )
                                                /*Image(
                                                  image: NetworkImage(url + e.image),
                                                  fit: BoxFit.cover,
                                                  height: 200.0,
                                                ),*/
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    height: 200.0,
                                    autoPlay: true,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(seconds: 1),
                                    autoPlayCurve: Curves.easeInBack,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 65,
                            ),
                            Text(
                              '  Top coupons',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 33,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: Text(
                                      'Show All ...  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    onTap: () {
                                      Get.to(
                                        () => CouponsScreen(),
                                        preventDuplicates: false,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 300,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10,
                                  top: MediaQuery.of(context).size.height / 70),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.160,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return CouponItem(
                                        homeController.coupons[index]);
                                  },
                                  itemCount: homeController.coupons.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class BrandItem extends StatelessWidget {
  late final Brand brand;

  BrandItem(this.brand);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => CouponsScreen(brandId: brand.id, brandName: brand.name),
          preventDuplicates: false,
        );
      },
      child: Card(
        margin: EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: progressIndicatorColor,
                ),
              ),
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: url + brand.image,
                fit: BoxFit.fill,
                height: 100,
                width: 100,
              )
            ],
          ),
        ),
        elevation: 4,
      ),
    );
  }
}

class CouponItem extends StatelessWidget {
  late final Coupon coupon;

  CouponItem(this.coupon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    _onShare(
                        context: context,
                        text: coupon.title,
                        des: coupon.des);
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    size: MediaQuery.of(context).size.height / 35,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width / 4.8,
            margin: EdgeInsets.only(left: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CircularProgressIndicator(
                      color: progressIndicatorColor,
                    ),
                  ),
                ),
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url + coupon.brand.image,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 15.5,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              coupon.des,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                //left: MediaQuery.of(context).size.width / 40,
                // right: MediaQuery.of(context).size.width / 40,
                bottom: MediaQuery.of(context).size.height / 110),
            height: MediaQuery.of(context).size.height / 22.5,
            child: GetCouponButton(coupon: coupon),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 130,
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                DottedLine(
                  lineLength: MediaQuery.of(context).size.width / 2.77,
                  dashLength: 16,
                  lineThickness: 2,
                  dashColor: Colors.black54,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 18,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  width: 50,
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
  void _onShare(
      {required BuildContext context, required String text, des}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      text,
      subject: des,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
