import 'package:couponaty/screens/home_screen.dart';
import 'package:get/get.dart';

import '../screens/brands_screen.dart';
import '../screens/category_screen.dart';
import '../screens/coupons_screen.dart';
import '../screens/favourite_screen.dart';
import '../screens/more_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/search_screen.dart';

class WelcomeController extends GetxController {


  /*void dependencies() {
    Get.lazyPut(() => WelcomeController());
    }*/
  var currentIndex = 0.obs;
  var screens = [
    HomeScreen(),
    BrandsScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ]; 


}//end of controller