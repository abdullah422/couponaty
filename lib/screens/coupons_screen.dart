import 'package:couponaty/screens/login_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../contants.dart';
import '../controllers/auth_controller.dart';
import '../controllers/coupon_controller.dart';
import '../models/coupon.dart';

class CouponsScreen extends StatefulWidget {
  final int? page, brandId;

  final String? brandName;

  const CouponsScreen({Key? key, this.page, this.brandId, this.brandName})
      : super(key: key);

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var couponController = Get.put(CouponController());
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    couponController.getCoupons(
      brandId: widget.brandId,
    );

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = couponController.isLoadingPagination.value;
      var hasMorePages =
          couponController.currentPage.value < couponController.lastPage.value;

      if (sControllerOffset > sControllerMax &&
          isLoadingPagination == false &&
          hasMorePages) {
        couponController.isLoadingPagination.value = true;
        couponController.currentPage.value++;
        couponController.getCoupons(
          page: couponController.currentPage.value,
          brandId: widget.brandId,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(widget.brandName == null
              ? 'Coupons'
              : widget.brandName.toString()),
        ),
        body: couponController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: progressIndicatorColor,
                ),
              )
            : couponController.coupons.isEmpty
                ? Center(child: Text('No data found'))
                : Container(
                    margin: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            itemBuilder: (context, index) {
                              return couponItem(
                                  couponController.coupons[index]);
                            },
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: couponController.coupons.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                          ),
                          Visibility(
                            visible: couponController.isLoadingPagination.value,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 40,
                              height: 40,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget couponItem(Coupon coupon) {
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
                              if (Get.find<AuthController>().isLoggedIn.value) {
                                couponController
                                    .addOrRemoveFromFavourites(
                                        couponId: coupon.id)
                                    .then((value) {
                                  setState(() {});
                                });
                              } else {
                                Get.to(() => LoginScreen());
                              }
                            },
                            padding: EdgeInsets.all(0),
                            icon: CircleAvatar(
                              backgroundColor:
                                  couponController.favorites[coupon.id] == true
                                      ? mainColor
                                      : Colors.grey,
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _onShare(
                                    context: context,
                                    text: coupon.title,
                                    des: coupon.des);
                              },
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

class GetCouponButton extends StatelessWidget {
  final Coupon coupon;

  const GetCouponButton({
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 16.7,
      child: InkWell(
        onTap: () {
          showMaterialModalBottomSheet(
            context: context,
            builder: (context) {
              return bottomSheetBody(context, coupon);
            },
           // barrierColor: backgroundColor?.withOpacity(0.3),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: Duration(milliseconds: 500),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: HexColor('#79BD9A'),
          ),
          width: MediaQuery.of(context).size.width / 1.29,
          height: double.infinity,
          child: Center(
            child: Text(
              'Get Coupon',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheetBody(BuildContext context, Coupon coupon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      margin: EdgeInsets.only(left: 10),
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                url + coupon.brand.image,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 3.8,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 40,
          ),
          Visibility(
            visible: coupon.code.isNotEmpty,
            child: Container(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 2,
              child: Neumorphic(
                style: NeumorphicStyle(depth: -5, color: backgroundColor),
                child: Center(
                    child: Text(
                  coupon.code,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                )),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: coupon.url.isNotEmpty,
                child: NeumorphicButton(
                  child: Text(
                      coupon.code.isEmpty
                          ? 'Go to store'
                          : 'Copy & Go to store',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (coupon.url.isEmpty) {
                    } else {
                      Clipboard.setData(ClipboardData(text: coupon.code));
                      if (await canLaunch(coupon.url)) {
                        await launch(
                          coupon.url,
                        );
                      }
                    }
                  },
                  style: NeumorphicStyle(color: mainColor, depth: 2),
                ),
              ),
              Visibility(
                visible: coupon.code.isNotEmpty && coupon.url.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OR'),
                ),
              ),
              Visibility(
                visible: coupon.code.isNotEmpty,
                child: NeumorphicButton(
                  child: Text('Copy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: coupon.code))
                        .then((value) {
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message:
                          "Copied Successfully",
                        ),
                      );
                     /* ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('copied successfully')));*/
                    });
                  },
                  style: NeumorphicStyle(color: mainColor, depth: 2),
                ),
              ),
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}
