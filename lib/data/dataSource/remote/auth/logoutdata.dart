import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class LogoutData {
  Crud crud;
  LogoutData(this.crud);

  logout() async {
    final response = await crud.postData(
      AppLink.logoutURL,
      {}, 
      {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
