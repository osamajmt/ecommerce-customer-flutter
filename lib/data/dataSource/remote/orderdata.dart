
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class OrderData {
  Crud crud = Crud();
  OrderData(this.crud);
  getPendingOrders(int userId) async {
    try {
      final response = await crud.getData("${AppLink.pendingOrders}", {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  getArchivedOrders(int userId) async {
    try {
      final response = await crud.getData("${AppLink.archivedOrders}", {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  getOrderDetails(int orderId) async {
    try {
      final response = await crud.getData("${AppLink.orderData}/$orderId", {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  deleteOrder(int orderId) async {
    try {
      final response = await crud.deleteData(
        "${AppLink.orders}/$orderId",
        {"order_id": orderId},
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  rateOrder(int orderId, String ratingComment, double rating) async {
    try {
      final response = await crud.postData(
        "${AppLink.rateOrder}/$orderId",
        { "ratingComment": ratingComment, "rating": rating},
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  checkout(
    int userId,
    int? addressId,
    int? couponId,
    int type,
    double totalPrice,
    double deliveryPrice,
    int paymentMethod,
  ) async {
    try {
      final response = await crud.postData(
        AppLink.orders,
        {
          "user_id": userId,
          "address_id": addressId,
          "coupon_id": couponId,
          "type": type,
          "total_price": totalPrice,
          "delivery_price": deliveryPrice,
          "payment_method": paymentMethod,
        },
        {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
}
