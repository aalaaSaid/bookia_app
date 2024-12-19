import 'dart:developer';

import 'package:booki_app/core/services/remote/end_point.dart';
import 'package:booki_app/feature/auth/data/models/user_model.dart';
import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/services/local/local_storge.dart';

class ProfileRepo {
//show Profile
  static Future<ProfileModel?>showProfile ()async{
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try{
      var response =await Dio().get(AppEndPoint.baseUrl+AppEndPoint.showProfile,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
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
//update profile
  static Future<bool?>updateProfile({required String? name ,required String? phone,required String? address,required String? image})async {
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try{
      var response = await Dio().
      post(AppEndPoint.baseUrl+AppEndPoint.updateProfile,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      data: FormData.fromMap({
        "name":name,
        "address":address,
        "phone":phone,
        if(image!=null)
          "image": await MultipartFile.fromFile(image,
          filename: image.split('/').last),
      }),
      );
      if(response.statusCode ==200){
        return true ;
      }else{
        return false ;
      }

    }on Exception catch(e){
      log(e.toString());
      return null ;
    }
  }
  //reset Password
  static Future<bool?>updatePassword({required String? currentPassword,required String? newPassword,required String? confirmNewPassword})async{
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try{
      var response = await Dio().post(AppEndPoint.baseUrl+AppEndPoint.resetPassword,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: {
          "current_password":currentPassword,
          "new_password":newPassword,
          "new_password_confirmation":confirmNewPassword
        }
      );
      if(response.statusCode ==200){
        return true ;
      }else{
        return false ;
      }
    }on Exception catch(e){
      log(e.toString());
      return false ;
    }
  }
  //logout 
  static Future<bool?> logout()async{
    late String token;
    await LocalStorge.getData('token').then((value) {
      token = value;
    });
    try{
      var response = await Dio().post(AppEndPoint.baseUrl+AppEndPoint.logout,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          )
      );
      if(response.statusCode==200){
        return true ;
      }else {
        return false;
      }

    }on Exception catch(e){
      log(e.toString());
      return false;
    }
  }
  //contact us
static Future<bool?>contact ({required String name  ,required String email,required String subject,required String message})async{
    try{
      var response = await Dio().post(
          AppEndPoint.baseUrl+AppEndPoint.contact,
      data: {
        "name":name,
        "email":email,
        "subject":subject,
        "message":message
      }
      );
      if(response.statusCode ==200){
        return true ;
      }else {
        return false ;
      }
    }on Exception catch(e){
      log(e.toString());
      return false;
    }
}
}