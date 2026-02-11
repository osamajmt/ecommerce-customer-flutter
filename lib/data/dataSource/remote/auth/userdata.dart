
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class UserData {
  Crud crud = Crud();
  UserData(this.crud);
  user(int id) async {
    try {
      final response = await crud.getData("${AppLink.getUser}/id", 
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}