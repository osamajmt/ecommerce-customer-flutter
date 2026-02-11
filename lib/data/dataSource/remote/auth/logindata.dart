
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class LoginData {
  Crud crud = Crud();
  LoginData(this.crud);
  login(String email, String password) async {
    try {
      final response = await crud.postData(AppLink.loginURL, {
        "email": email,
        "password": password,
      }
      ,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}