
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class HomeData {
  Crud crud = Crud();
  HomeData(this.crud);
  getCategories() async {
    try {
      final response = await crud.getData(AppLink.categories,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getItems() async {
    try {
      final response = await crud.getData(AppLink.items,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getSettings() async {
    try {
      final response = await crud.getData(AppLink.settings,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getTopSellingItems($userId) async {
    try {
      final response = await crud.postData(AppLink.itemsTopSelling,
      {
        "userId":$userId
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  getDiscountItems() async {
    try {
      final response = await crud.getData(AppLink.discountItems,
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
  searchItems(String search) async {
    try {
      final response = await crud.postData(AppLink.itemsSearch,
      {
        'search':search
      },
       {
        'Accept': 'application/json', 
        'Content-Type': 'application/json',
      });
      return response.fold((l)=>l, (r)=>r);
    } catch (e) {}
  }
}