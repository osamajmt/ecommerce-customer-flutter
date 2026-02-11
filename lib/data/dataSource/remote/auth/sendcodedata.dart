

import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class SendCodeData {
  Crud crud = Crud();
  SendCodeData(this.crud);
  sendCode(String email) async {
    try {
      final response = await crud.patchData(AppLink.sendCode, {
        "email": email,
      },{});
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}

