
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class CartData {
  Crud crud = Crud();
  CartData(this.crud);
  getCart() async {
    try {
      final response = await crud.getData(AppLink.cart,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
 addCart(int itemId)async
    {
    try {
      final response = await crud.postData(AppLink.cart,{
        "item_id": itemId,
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
 removeCart( int itemId) async {
    try {
      final response = await crud.deleteData(
        AppLink.cartDelete,
        {
          "item_id": itemId,
        }, 
        {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }
 decreaseCount( int itemId) async {
    try {
      final response = await crud.postData(
        AppLink.cartDecrease,
        {
          "item_id": itemId,
        }, 
        {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }

  clearCart() async {
    try {
      final response = await crud.deleteData(
        AppLink.cartClear,
        {
        }, 
        {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      return {'success': false, 'message': 'Network error'};
    }
  }
  getCartItemCount(int itemId)async{
    try {
      final response = await crud.getData("${AppLink.cartItemCount}/$itemId",
        {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },);
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
   checkCoupon(String couponName) async {
    try {
      final response = await crud.postData(AppLink.coupon,
      {
        "coupon_name":couponName
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}
