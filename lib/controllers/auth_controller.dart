import 'package:couponaty/controllers/base_controller.dart';
import 'package:couponaty/controllers/home_controller.dart';
import 'package:couponaty/controllers/welcom_controller.dart';
import 'package:couponaty/models/user.dart';
import 'package:couponaty/responses/user_response.dart';
import 'package:couponaty/screens/welcome_screen.dart';
import 'package:couponaty/services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with BaseController {
  var isLoggedIn = false.obs;
  var user = User().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    // homeController.getHomeData();
    redirect();

    super.onInit();
  }

  Future<void> redirect() async {
    var token = await GetStorage().read('login_token');

    if (token != null) {
      print('==============================' + token.toString());
      getUser();
    }
    Future.delayed(Duration(seconds: 6 )).then((value) {
      Get.off(
        () => WelcomeScreen(),
        preventDuplicates: false,
      );
    }).catchError((error) {
      print('${error.toString()}');
    });
  } // end of redirect

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showLoading();
    var response = await Api.login(loginData: loginData);

    var userResponse = UserResponse.fromJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;
    hideLoading();
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of login

  Future<void> register({required Map<String,dynamic> registerData}) async {
    showLoading();
    var response = await Api.register(registerData: registerData);

    var userResponse = UserResponse.fromJson(response.data);
    await GetStorage().write('login_token', userResponse.token);
    user.value = userResponse.user;
    isLoggedIn.value = true;
    hideLoading();
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of register

  Future<void> getUser() async {
    var response = await Api.getUser();
    var userResponse = UserResponse.fromJson(response.data);
    user.value = userResponse.user;
    isLoggedIn.value = true;
  } // end of getUser

  Future<void> logout() async {
    isLoggedIn.value = false;
    await GetStorage().remove('login_token');
    Get.find<WelcomeController>().currentIndex.value = 0;
    Get.offAll(() => WelcomeScreen());
  } // end of logout

} //end of controller
