import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:booki_app/feature/auth/presentation/pages/password_pages/success_password_change.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/functions/navigation.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../core/widgets/custom_button.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key,required this.otp});
  final String otp;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final newPasswordController =TextEditingController();
  final confirmationNewPasswordController =TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
   if(state is ResetPasswordLoadingState){
     showLoadingDialog(context);
   }else if(state is ResetPasswordErrorState){
     Navigator.pop(context);
     showErrorDialog(context, 'Something Went Wrong');
   }else if(state is ResetPasswordSuccessState){
     navigateRemove(context, const SuccessPasswordChange());
   }
  },
  child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create new password',style: getHeadlineTextStyle(),),
                const Gap(10),
                Text('Your new password must be unique from those previously used.',style: getSubTitleTextStyle(),)
                ,const Gap(30),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Enter your new Password',
                    hintStyle: TextStyle(color: AppColors.greyColor),
                  ),
                  controller: newPasswordController,
                  validator: (value){
                    if(value ==null || value.isEmpty){
                      return 'Please enter the correct input';
                    }
                    return null ;
                  },
                ),
                const Gap(10),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: AppColors.greyColor),
                  ),
                  controller: confirmationNewPasswordController,
                  validator: (value){
                    if(value ==null || value.isEmpty){
                      return 'Please enter the correct input';
                    }
                    return null ;
                  },
                ),
                const Gap(30),
                CustomButton(onPressed: (){
                context.read<AuthBloc>().
                add(ResetPasswordEvent(
                    verifyCode: widget.otp,
                    newPassword: newPasswordController.text,
                    confirmNewPassword: confirmationNewPasswordController.text));
                }, text: 'Reset Password',
                  width: double.infinity,
                ),
            
              ],
            ),
          ),
        ),
      ),
    ),
);
  }
}
