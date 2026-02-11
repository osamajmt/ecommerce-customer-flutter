
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class VerifyEmailData {
  Crud crud = Crud();
  VerifyEmailData(this.crud);
  verifyEmail(String email, String code) async {
    try {
      final response = await crud.postData(AppLink.verifyEmail, {
        "email": email,
        "verify_code": code,
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  sendCode(String email) async {
    try {
      final response = await crud.postData(AppLink.sendCode, {
        "email": email,
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}

