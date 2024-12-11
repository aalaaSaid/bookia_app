
class AuthEvent {}
//login
class LoginEvent extends AuthEvent {
  final String email ;
  final String password ;

  LoginEvent({
    required this.email,
    required this.password});

}
//register
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation});

}
//forget password
class ForgetPasswordEvent extends AuthEvent {
  final String? email;

  ForgetPasswordEvent({required this.email});
}
//check otp
class CheckOtpEvent extends AuthEvent{
  final String? otp ;

  CheckOtpEvent({required this.otp});

}
//reset password
class ResetPasswordEvent extends AuthEvent {
  final String? verifyCode;
  final String? newPassword;
  final String? confirmNewPassword;

  ResetPasswordEvent({required this.verifyCode, required this.newPassword, required this.confirmNewPassword});




}