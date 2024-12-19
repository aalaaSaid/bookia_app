class ProfileState {}
class InitialProfileState extends ProfileState{}
//show
class ShowProfileLoadingState extends ProfileState{}
class ShowProfileSuccessState extends ProfileState{}
class ShowProfileErrorState extends ProfileState{}
//update
class UpdateProfileErrorState extends ProfileState{}
class UpdateProfileSuccessState extends ProfileState{}
class UpdateProfileLoadingState extends ProfileState{}
//reset Password
class UpdatePasswordSuccessState extends ProfileState{}
class UpdatePasswordErrorState extends ProfileState{}
class UpdatePasswordLoadingState extends ProfileState{}
//logout
class LogoutSuccessState extends ProfileState{}
class LogoutErrorState extends ProfileState{}
class LogoutLoadingState extends ProfileState{}
//contact us
class ContactLoadingState extends ProfileState{}
class ContactErrorState extends ProfileState{}
class ContactSuccessState extends ProfileState{}