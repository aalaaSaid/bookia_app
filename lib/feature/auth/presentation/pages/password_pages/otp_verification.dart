import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_event.dart';
import 'package:booki_app/feature/auth/presentation/bloc/auth_state.dart';
import 'package:booki_app/feature/auth/presentation/pages/password_pages/forget_password.dart';
import 'package:booki_app/feature/auth/presentation/pages/password_pages/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../core/widgets/custom_button.dart';
class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String otp ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is CheckOtpErrorState){
      showLoadingDialog(context);
    }else if(state is CheckOtpErrorState){
      Navigator.pop(context);
      showErrorDialog(context, 'Something Went wrong');
    }else if(state is CheckOtpSuccessState){
      Navigator.pop(context);
      navigateTO(context, ResetPassword(otp: otp,));
    }
  },
  child: SingleChildScrollView(
    child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OTP Verification',style: getHeadlineTextStyle(),),
              const Gap(10),
              Text('Enter the verification code we just sent on your email address.',style: getSubTitleTextStyle(),)
              ,const Gap(20),
              Center(
                child: Pinput(
                  length: 6,
                  onCompleted: (pin){
                    otp = pin ;
                    context.read<AuthBloc>().
                    add(CheckOtpEvent(otp: pin));
                  },
                  defaultPinTheme: PinTheme(
                    height: 70,
                    width: 60,
                    textStyle: getSubTitleTextStyle(),
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ),
              const Gap(30),
              CustomButton(onPressed: (){
                if(otp.isNotEmpty){
                  context.read<AuthBloc>().add(CheckOtpEvent(otp: otp));
                }
                 }, text: 'Verify',
                width: double.infinity,
              ),

    
            ],
          ),
        ),
  ),
),
      bottomNavigationBar:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Didn’t received code?',style: getSubTitleTextStyle(),),
          TextButton(onPressed: (){
            navigateRemove(context, const ForgetPassword());
          }, child: Text('Resend',style: getSubTitleTextStyle(color: AppColors.primaryColor),))
        ],
      ),
    );
  }
}
