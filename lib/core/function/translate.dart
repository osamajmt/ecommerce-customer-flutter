import 'package:ecommerce_app/core/services/services.dart';
import 'package:get/get.dart';

translate(arColumn, enColumn) {
  Services myServices = Get.find();
  if (myServices.sharedPreferences.getString("lang") == "ar") {
    return arColumn;
  } else {
    return enColumn;
  }
}
