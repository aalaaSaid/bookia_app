import 'package:booki_app/feature/auth/presentation/pages/login_sc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/functions/navigation.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
class SuccessPasswordChange extends StatelessWidget {
  const SuccessPasswordChange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/Successmark.svg',
                height: 150,
                width: 150,
              ),
              const Gap(30),
              Text('SUCCESS!',
                style: getHeadlineTextStyle(),
              ),
              const Gap(10),
              Text('Your password has been changed successfully.',
                style: getSmallTextStyle(
                    color: AppColors.greyColor
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              CustomButton(onPressed: (){
                navigateReplacement(context, const LoginScreen());
              }, text: 'Back To Login',
                width: double.infinity,
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
