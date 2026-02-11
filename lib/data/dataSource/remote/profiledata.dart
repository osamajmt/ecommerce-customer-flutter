import 'dart:convert';
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/core/services/services.dart';
import 'package:ecommerce_app/linkapi.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileData {
  Crud crud = Crud();
  ProfileData(this.crud);
 updateImage(String id,String imagePath) async {
    try {
       Services myServices = Get.find();
      String? token = await myServices.secureStorage.read(key: "token");

     var request =
          http.MultipartRequest("POST", Uri.parse(AppLink.updateUserImage));

        request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      request.fields['userId'] = id;

     if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imagePath));
      }
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      return jsonDecode(responseBody.body);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }
}