import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/core/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({super.key});

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
              Text('Your order will be delivered soon.\nThank you for choosing our app!',
              style: getSmallTextStyle(
                color: AppColors.greyColor
              ),
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              CustomButton(onPressed: (){
                navigateReplacement(context, const NavBar());
              }, text: 'Back To Home',
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
