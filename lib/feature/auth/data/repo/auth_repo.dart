import 'dart:developer';

import 'package:booki_app/core/services/remote/end_point.dart';
import 'package:booki_app/feature/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  //register
  static Future<UserModel?> register(
      {required String name,
      required String email,
      required String password,
      required String passwordConfirmation}) async {
    try {
      var response =
          await Dio().post(AppEndPoint.baseUrl + AppEndPoint.register, data: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation
      });
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

// login
  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      var response =
          await Dio().post(AppEndPoint.baseUrl + AppEndPoint.login, data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  //forget Password
  static Future<bool?> forgetPassword({required String? email}) async {
    try {
      var response = await Dio()
          .post(AppEndPoint.baseUrl + AppEndPoint.forgotPassword, data: {
        "email": email,
      });
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

  // check the otp
  static Future<bool?> checkOtp({required String? otp}) async {
    try {
      var response =
          await Dio().post(AppEndPoint.baseUrl + AppEndPoint.checkOtp, data: {
        "verify_code": otp,
      });
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

  // reset password
  static Future<bool?> resetPassword(
      {required String? verifyCode,
      required String? newPassword,
      required String? confirmNewPassword}) async {
    try {
      var response = await Dio()
          .post(AppEndPoint.baseUrl + AppEndPoint.resetNewPassword, data: {
        "verify_code": verifyCode,
        "new_password": newPassword,
        "new_password_confirmation": confirmNewPassword
      });
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
