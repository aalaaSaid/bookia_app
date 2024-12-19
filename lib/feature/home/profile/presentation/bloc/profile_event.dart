import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';

class ProfileEvent {}
//show
class ShowProfileEvent extends ProfileEvent{}
//update
class UpdateProfileEvent extends ProfileEvent{
 final String? name ;
 final String? phone ;
 final String? address;
 final String? image;

  UpdateProfileEvent({required this.name, this.phone,  this.address, this.image});

}
//reset password
class UpdatePasswordEvent extends ProfileEvent{
 final String? currentPassword ;
 final String? newPassword ;
 final String? confirmNewPassword ;

  UpdatePasswordEvent({required this.currentPassword, required this.newPassword, required this.confirmNewPassword});

}
//logout
class LogoutEvent extends ProfileEvent{
}
// contact
class ContactEvent extends ProfileEvent{
 final String? name;
 final String? email ;
 final String? massage ;
 final String? subject ;

  ContactEvent({required this.name,required this.email, required this.massage, required this.subject});
}