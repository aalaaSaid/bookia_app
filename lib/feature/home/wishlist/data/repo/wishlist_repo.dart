import 'dart:developer';

import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/core/services/remote/end_point.dart';
import 'package:booki_app/feature/home/wishlist/data/models/wishlist_model.dart';
import 'package:dio/dio.dart';

class WishListRepo {
  static Future<WishlistModel?> getWishlist() async {
    try {
      late String token;
      await LocalStorge.getData('token').then((value) {
        token = value;
      });
      var response = await Dio().get(
        AppEndPoint.baseUrl + AppEndPoint.showWishlist,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
       // print(response.data);
        return WishlistModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> addToWishList({required int productId}) async {
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try {
      var response = await Dio().post(
        AppEndPoint.baseUrl + AppEndPoint.addToWishlist,
        data: {
          "product_id": productId,
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
  static Future<bool> removeFromWishList({required int productId}) async {
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try {
      var response = await Dio().post(
        AppEndPoint.baseUrl + AppEndPoint.removeFromWishlist,
        data: {
          "product_id": productId,
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

}
