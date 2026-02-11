
import 'package:ecommerce_app/core/class/crud.dart';
import 'package:ecommerce_app/linkapi.dart';

class AddressData {
  Crud crud = Crud();
  AddressData(this.crud);
  
 getAddresses(int userId)async
    {
    try {
      final response = await crud.getData(AppLink.addressView, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  addAddress(String city,String name,String street,String lat,String long)async
    {
    try {
      final response = await crud.postData(AppLink.address,{
        "city": city,
        "name": name,
        "street": street,
        "latitude": lat,
        "longitude": long,
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  editAddress(int addressId,String name,String city,String street,double latitude,double longitude)async
    {
    try {
      final response = await crud.patchData("${AppLink.address}/$addressId",{
        "name": name,
        "city": city,
        "street": street,
        "latitude": latitude,
        "longitude": longitude,
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
  deleteAddress(int addressId)async
    {
    try {
      final response = await crud.deleteData("${AppLink.address}/${addressId}",{
      }, {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },);
      return response.fold((l) => l, (r) => r);
    } catch (e) {}
  }
}
