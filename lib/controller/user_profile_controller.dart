import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:ecommerce_app/core/function/handlingdata.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/data/dataSource/remote/profiledata.dart';
import 'package:ecommerce_app/data/dataSource/static/app_routes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserProfileController extends GetxController {
  Services myServices = Get.find();
  ProfileData profileData = ProfileData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  String? userId;
  String? userName;
  String? userEmail;
  String? role;
  String? image;
  XFile? pickedImage;
  pickImage();
  Map<String, dynamic>? user;
  getUserData();
}

class UserProfileControllerImp extends UserProfileController {
  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  @override
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      update();
    }
  }

  updateImage() async {
    try {
      statusRequest = StatusRequest.loading;
      print(1);
      var response = await profileData.updateImage(userId!, pickedImage!.path);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          image = response['image'];
          myServices.sharedPreferences.setString("image", image!);
          Get.toNamed(appRoute.userProfile);
        } else {
          Get.defaultDialog(title: 'Warning', middleText: " invalid");
          statusRequest = StatusRequest.failure;
        }
      } else {
        statusRequest = response;
        if (statusRequest == StatusRequest.serverFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "Server error. Please try again later.",
          );
        } else if (statusRequest == StatusRequest.offlineFailure) {
          Get.defaultDialog(
            title: 'Error',
            middleText: "No internet connection.",
          );
        }
      }
      update();
    } catch (e) {
      print("Unexpected error: $e");
      statusRequest = StatusRequest.serverException;
      Get.defaultDialog(
        title: 'Error',
        middleText: "An unexpected error occurred",
      );
    }
  }

  @override
  getUserData() async {
    statusRequest = StatusRequest.loading;
    update();
    userName = myServices.sharedPreferences.getString("user_name");
    userId =int.parse(  await myServices.secureStorage.read(key: "user_id") ?? "0",).toString();
    userEmail = await myServices.secureStorage.read(key: "email");
    role = await myServices.secureStorage.read(key: "role");
    image = myServices.sharedPreferences.getString("image");
    statusRequest = StatusRequest.success;
    update();
  }
}
