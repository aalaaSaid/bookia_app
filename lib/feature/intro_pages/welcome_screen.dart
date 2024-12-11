import 'package:booki_app/core/constants/asset_icons.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/feature/auth/presentation/pages/login_sc.dart';
import 'package:booki_app/feature/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              const Image(image: AssetImage('assets/images/welcome.png'),
              height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2,),
                    SizedBox(
                        width: 210,
                        height: 66,
                        child: SvgPicture.asset(AssetIcons.logo)),
                    const Gap(10),
                    Text(
                      'Order Your Book Now!',
                      style: getTitleTextStyle(),
                    ),
                    const Spacer(flex: 5,) ,
                    CustomButton(
                      onPressed: (){
                        navigateTO(context, const LoginScreen());
                      },
                        text: 'Login',
                    ) ,
                    const Gap(10),
                    CustomButton(
                      onPressed:(){
                        navigateTO(context, const RegisterScreen());
                      },
                        text: 'Register',
                    color: AppColors.whiteColor,

                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          )

        )
    );
  }
}
