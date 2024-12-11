import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_back_button.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:booki_app/feature/auth/presentation/pages/login_sc.dart';
import 'package:booki_app/feature/auth/presentation/pages/password_pages/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoadingState) {
            showLoadingDialog(context);
          } else if (state is ForgetPasswordErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, 'oh no!');
          } else if (state is ForgetPasswordSuccessState) {
            Navigator.pop(context);
            navigateTO(context, const OtpVerification());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password?',
                    style: getHeadlineTextStyle(),
                  ),
                  const Gap(10),
                  Text(
                    'Don\'t worry! It occurs.\nPlease enter the email address linked with your account.',
                    style: getSubTitleTextStyle(),
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: AppColors.greyColor),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                            ForgetPasswordEvent(email: emailController.text));
                      }
                    },
                    text: 'Send Code',
                    width: double.infinity,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Remember Password?',
            style: getSubTitleTextStyle(),
          ),
          TextButton(
              onPressed: () {
                navigateRemove(context, const LoginScreen());
              },
              child: Text(
                'Login',
                style: getSubTitleTextStyle(
                    color: AppColors.primaryColor),
              ))
        ],
      ) ,
    );
  }
}
