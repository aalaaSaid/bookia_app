import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_back_button.dart';
import 'package:booki_app/core/widgets/nav_bar.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:booki_app/feature/auth/presentation/pages/login_sc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  bool obscureText1 = true;
  bool obscureText2 = true;
  final confirmPasswordController = TextEditingController();

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
          if (state is RegisterLoadingState) {
            showLoadingDialog(context);
          } else if (state is RegisterSuccessState) {
            navigateRemove(context, const NavBar());
          } else if (state is RegisterErrorState) {
            //pop the loading .
            Navigator.pop(context);
            showErrorDialog(context, 'something went wrong');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello! Register to get started',
                  style: getHeadlineTextStyle(),
                ),
                const Gap(20),
                //name
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: getSmallTextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the correct unput';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                //email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: getSmallTextStyle(
                      color: AppColors.greyColor,
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the correct unput';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                //password
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  obscureText: obscureText1,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 22,
                      maxWidth: 22,
                    ),
                    suffixIcon: GestureDetector(
                      child: SvgPicture.asset('assets/icons/eye.svg'),
                      onTap: () {
                        setState(() {
                          obscureText1 = !obscureText1;
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
                const Gap(10),
                //confirmPassword
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: obscureText2,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                    suffixIconConstraints: const BoxConstraints(
                      maxHeight: 22,
                      maxWidth: 22,
                    ),
                    suffixIcon: GestureDetector(
                      child: SvgPicture.asset('assets/icons/eye.svg'),
                      onTap: () {
                        setState(() {
                          obscureText2 = !obscureText2;
                        });
                      },
                    ),
                  ),
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Correct input';
                    }
                    return null;
                  },
                ),
                const Gap(20),
                //register event
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(RegisterEvent(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation:
                              confirmPasswordController.text));
                    }
                  },
                  text: 'Register',
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
                      'Or Register with',
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
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () {
                          navigateTO(context,const LoginScreen());
                        },
                        child: Text(
                          'Login Now',
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
