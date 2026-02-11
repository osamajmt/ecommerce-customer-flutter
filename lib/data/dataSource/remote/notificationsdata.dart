
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class NotificationsData {
  Crud crud = Crud();
  NotificationsData(this.crud);
  getNotifications($userId) async {
    try {
      final response = await crud.getData(
        AppLink.notifications,
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
}
