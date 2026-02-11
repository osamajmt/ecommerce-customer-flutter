import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/localization/changelocal.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(Crud(), permanent: true);
     Get.put(Services(), permanent: true);
      Get.put(LocalController(), permanent: true);
  }
}
