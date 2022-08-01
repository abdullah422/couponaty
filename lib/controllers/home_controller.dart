import 'package:couponaty/controllers/welcom_controller.dart';
import 'package:couponaty/models/banner.dart';
import 'package:couponaty/models/coupon.dart';
import 'package:couponaty/responses/banner_response.dart';
import 'package:couponaty/responses/home_resopnse.dart';
import 'package:couponaty/services/api.dart';
import 'package:get/get.dart';

import '../models/brand.dart';
import '../responses/brand_response.dart';

class HomeController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    getHomeData();
    super.onInit();
  }

  var isLoading = true.obs;
  var banners = <Banner>[].obs;
  var brands = <Brand>[].obs;
  var coupons = <Coupon>[].obs;

  Future<void> getHomeData() async {
    isLoading.value =true;
    var response = await Api.homeData();

    var homeResponse = HomeResponse.fromJson(response.data);

    banners.clear();
    banners.addAll(homeResponse.banners);

    brands.clear();
    brands.addAll(homeResponse.brands);

    coupons.clear();
    coupons.addAll(homeResponse.coupons);
    isLoading.value = false;
  } // end of getBanners

} //end of controller
