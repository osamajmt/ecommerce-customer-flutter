
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';
class ItemsData {
  Crud crud = Crud();
  ItemsData(this.crud);
  getAllItems() async {
    try {
      final response = await crud.getData(AppLink.items, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }

  getItems(int catId) async {
    try {
      final response = await crud.getData('${AppLink.items}/$catId', {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  getFavItems(int userId) async {
    try {
      final response = await crud.getData(AppLink.favItems, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  toggleFavorite(int itemId,int userId)async
    {
    try {
      final response = await crud.postData(AppLink.toggleItem,{
        "itemId": itemId,
        "userId": userId,
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  
  getDiscountItems(int userId) async {
    try {
      final response = await crud.postData(AppLink.discountItems,
      { "userId": userId,
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
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
   searchOffers(String search) async {
    try {
      final response = await crud.postData(AppLink.itemsOffersSearch,
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


