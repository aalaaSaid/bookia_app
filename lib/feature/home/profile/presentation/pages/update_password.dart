import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_bloc.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_event.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../core/widgets/custom_button.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({super.key});

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if(state is UpdatePasswordLoadingState){
            showLoadingDialog(context);
          }else if(state is UpdatePasswordErrorState){
            Navigator.pop(context);
            showErrorDialog(context, 'Something went wrong');
          }else if(state is UpdatePasswordSuccessState){
            Navigator.pop(context);
            //navigateReplacement(context, const SuccessPasswordChange());
             showErrorDialog(context, 'Your Password Update Successful');
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New Password', style: getHeadlineTextStyle(),),
                  const Gap(30),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter Current Password',
                      hintStyle: TextStyle(color: AppColors.greyColor),
                    ),
                    controller: currentPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter new Password',
                      hintStyle: TextStyle(color: AppColors.greyColor),
                    ),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Confirm your new Password',
                      hintStyle: TextStyle(color: AppColors.greyColor),
                    ),
                    controller: newPasswordConfirmationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  CustomButton(onPressed: () {
                    if(formKey.currentState!.validate()){
                      context.read<ProfileBloc>().add(UpdatePasswordEvent(
                          currentPassword:currentPasswordController.text ,
                          newPassword: newPasswordController.text,
                          confirmNewPassword: newPasswordConfirmationController.text));
          
                    }
                    // NavigateTO(context, const SuccessPasswordChange());
                  }, text: 'Update Password',
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
