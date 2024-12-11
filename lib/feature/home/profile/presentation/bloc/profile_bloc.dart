import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';
import 'package:booki_app/feature/home/profile/data/repo/profile_repo.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_event.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitialProfileState()) {
    on<ShowProfileEvent>(showProfile);
    on<UpdateProfileEvent>(updateProfile);
    on<UpdatePasswordEvent>(updatePassword);
    on<LogoutEvent>(logout);
  }
  ProfileModel? profileModel;
  Future<void> showProfile(
      ShowProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ShowProfileLoadingState());
    await ProfileRepo.showProfile().then((value) {
      if (value != null) {
        profileModel = value;
        emit(ShowProfileSuccessState());
      } else {
        emit(ShowProfileErrorState());
      }
    });
  }

  Future<void> updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileLoadingState());
    await ProfileRepo.updateProfile(
            name: event.name,
            phone: event.phone,
            address: event.address,
            image: event.image)
        .then((value) {
      if (value == true) {
        emit(UpdateProfileSuccessState());
      } else {
        emit(UpdateProfileErrorState());
      }
    });
  }
  Future<void>updatePassword(UpdatePasswordEvent event , Emitter<ProfileState>emit)async{
    emit(UpdatePasswordLoadingState());
    await ProfileRepo.updatePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmNewPassword: event.confirmNewPassword).then((value){
          if(value == true){
            emit(UpdatePasswordSuccessState());
          }else{
            emit(UpdatePasswordErrorState());
          }
    });

  }

  Future<void>logout(LogoutEvent event , Emitter<ProfileState>emit)async{
    emit(LogoutLoadingState());
   await ProfileRepo.logout().then((value){
     if(value == true){
       LocalStorge.removeData('token');
       emit(LogoutSuccessState());
     }else{
       emit(LogoutErrorState());
     }
   });
  }
}

