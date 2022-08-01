import 'package:couponaty/models/category.dart';
import 'package:couponaty/responses/category_response.dart';
import 'package:couponaty/services/api.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    getCategories();
    super.onInit();
  }
  var categories = <Category>[].obs;

  Future<void> getCategories() async {
    var response = await Api.getCategories();
    var categoryResponse = CategoryResponse.fromJson(response.data);
    categories.clear();
    categories.addAll(categoryResponse.categories);
  } // end of getCategories

} //end of controller
