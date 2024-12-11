import 'package:booki_app/core/constants/asset_icons.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/services/local/local_storge.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/nav_bar.dart';
import 'package:booki_app/feature/intro_pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    String? token;
    LocalStorge.getData('token').then((value){
      token = value;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if(token !=null ){
        navigateReplacement(context, const NavBar());
      }else{

        navigateReplacement(context, const WelcomeScreen());
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 210,
                  height: 66,
                  child: SvgPicture.asset(AssetIcons.logo)),
              const Gap(10),
              Text(
                'Order Your Book Now!',
                style: getTitleTextStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
