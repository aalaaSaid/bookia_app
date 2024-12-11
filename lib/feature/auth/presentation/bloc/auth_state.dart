class AuthState {}
// initialState
class AuthInitialState extends AuthState {}
//login states
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}
//register state
class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {}
//forget password
class ForgetPasswordSuccessState extends AuthState{}
class ForgetPasswordErrorState extends AuthState{}
class ForgetPasswordLoadingState extends AuthState{}
//check otp
class CheckOtpSuccessState extends AuthState{}
class CheckOtpErrorState extends AuthState{}
class CheckOtpLoadingState extends AuthState{}
//reset Password
class ResetPasswordSuccessState extends AuthState{}
class ResetPasswordErrorState extends AuthState{}
class ResetPasswordLoadingState extends AuthState{}

