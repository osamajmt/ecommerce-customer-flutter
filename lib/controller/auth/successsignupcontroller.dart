import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';

abstract class successSignupController extends GetxController {

  goToLogin();
}

class successSignupControllerImp extends successSignupController {

  @override
  goToLogin() {
    Future.microtask(() => Get.offAllNamed(appRoute.login));
  }

 

  @override
  void dispose() {
    super.dispose();
  }
}
