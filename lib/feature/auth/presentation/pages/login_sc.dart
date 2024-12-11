import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_back_button.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/core/widgets/nav_bar.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:booki_app/feature/auth/presentation/pages/password_pages/forget_password.dart';
import 'package:booki_app/feature/auth/presentation/pages/register_screen.dart';
import 'package:booki_app/feature/auth/presentation/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showLoadingDialog(context);
          } else if (state is LoginSuccessState) {
            navigateRemove(context, const NavBar());
          } else if (state is LoginErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, 'Something went wrong');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Welcome back! Glad to see you, Again!',
                  style: getHeadlineTextStyle(),
                ),
                const Gap(20),
                //email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Correct input';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                //password
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 22,
                      maxWidth: 22,
                    ),
                    suffixIcon: GestureDetector(
                      child: SvgPicture.asset('assets/icons/eye.svg'),
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Correct input';
                    }
                    return null;
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          navigateTO(context, const ForgetPassword());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: getBodyTextStyle(),
                        ))
                  ],
                ),
                const Gap(20),
                //login event
                CustomButton(
                  onPressed: () {
                   if(formKey.currentState!.validate()){
                     context.read<AuthBloc>().add(LoginEvent(
                         email: emailController.text,
                         password: passwordController.text));
                   }
                  },
                  text: 'Login',
                  width: double.infinity,
                ),
                const Gap(20),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      'Or Login with',
                      style: getSmallTextStyle(),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                CustomSocialButton(),
                const Spacer(
                  flex: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account?'),
                    TextButton(
                        onPressed: () {
                          navigateRemove(context, const RegisterScreen());
                        },
                        child: Text(
                          'Register Now',
                          style:
                              getSmallTextStyle(color: AppColors.primaryColor),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
