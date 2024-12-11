import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/feature/auth/data/repo/auth_repo.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
    on<ForgetPasswordEvent>(forgetPassword);
    on<CheckOtpEvent>(checkOtp);
    on<ResetPasswordEvent>(resetPassword);
  }
  // this variable will show in all application
  UserModel? userModel;
  Future<void> register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    await AuthRepo.register(
            name: event.name,
            email: event.email,
            password: event.password,
            passwordConfirmation: event.passwordConfirmation)
        .then((value) {
      if (value != null) {
        userModel = value;
        LocalStorge.cacheData('token', value.data.token);
        emit(RegisterSuccessState());
      } else {
        emit(RegisterErrorState());
      }
    });
  }

  Future<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());
    await AuthRepo.login(email: event.email, password: event.password)
        .then((value) {
      if (value != null) {
        userModel = value;
        LocalStorge.cacheData('token', value.data.token);
        //print(value.data.token);
        //print(LocalStorge.getData('token'));
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState());
      }
    });
  }
  Future<void>forgetPassword(ForgetPasswordEvent event,Emitter<AuthState>emit)async {
    emit(ForgetPasswordLoadingState());
    await AuthRepo.forgetPassword(email: event.email).then((value){
      if(value == true){
        emit(ForgetPasswordSuccessState());
      }else{
        emit(ForgetPasswordErrorState());
      }
    });

  }
  Future<void>checkOtp(CheckOtpEvent event,Emitter<AuthState>emit)async{
    emit(CheckOtpLoadingState());
    await AuthRepo.checkOtp(otp: event.otp).then((value){
      if(value==true){
        emit(CheckOtpSuccessState());
      }else{
        emit(CheckOtpErrorState());
      }
    });

  }
  Future<void>resetPassword(ResetPasswordEvent event,Emitter<AuthState>emit)async{
    emit(ResetPasswordLoadingState());
    await AuthRepo.resetPassword(
        verifyCode: event.verifyCode,
        newPassword: event.newPassword,
        confirmNewPassword: event.confirmNewPassword).then((value){
          if(value == true){
            emit(ResetPasswordSuccessState());
          }else{
            emit(ResetPasswordErrorState());
          }
    });

  }
}
