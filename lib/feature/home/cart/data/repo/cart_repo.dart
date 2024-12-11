
import 'dart:developer';

import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/core/services/remote/end_point.dart';
import 'package:booki_app/feature/home/cart/data/models/cart_model.dart';
import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

class CartRepo {
  //show cart
  static Future<CartModel?> getCart() async {
    try {
      late String token;
      await LocalStorge.getData('token').then((value) {
        token = value;
      });
      var response = await Dio().get(
        AppEndPoint.baseUrl + AppEndPoint.showCart,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        // print(response.data);
        return CartModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
// add to cart
  static Future<bool?> addToCart({required int productId}) async {
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try {
      var response = await Dio().post(
        AppEndPoint.baseUrl + AppEndPoint.addToCart,
        data: {
          "product_id": productId,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
  //remove from cart
  static Future<bool?> removeFromCart({required int productId}) async {
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try {
      var response = await Dio().post(
        AppEndPoint.baseUrl + AppEndPoint.removeFromCart,
        data: {
          "cart_item_id": productId,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
  //update cart
static Future<bool?>updateCart({required int productId,required int quantity})async{
  late String token;
  await LocalStorge.getData('token').then((value) {
    token = value;
  });
   try{
     var response = await Dio().post(AppEndPoint.baseUrl+AppEndPoint.updateCard,
     data: {
       "cart_item_id":productId,
       "quantity":quantity,
     },
       options: Options(
         headers: {'Authorization': 'Bearer $token'}
       ),
     );
     if(response.statusCode==201){
       return true ;
     }else{
       return false ;
     }
   }on Exception catch(e){
     log(e.toString());
     return null ;
   }
}
//checkout
static Future<ProfileModel?>getCheckout()async{
  late String token;
  await LocalStorge.getData('token').then((value) {
    token = value;
  });
    try{
      var response = await Dio().get(AppEndPoint.baseUrl+AppEndPoint.getCheckout,
      options: Options(
        headers: {'Authorization': 'Bearer $token'}
      )
      );
      if(response.statusCode==200){
        return ProfileModel.fromJson(response.data);
      }else{
        return null ;
      }
    }on Exception catch(e){
      log(e.toString());
       return null ;
    }
}
}
