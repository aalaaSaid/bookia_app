import 'package:booki_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CustomSocialButton extends StatelessWidget {
  CustomSocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset('assets/images/facebook.svg'),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accentColor),
                  borderRadius: BorderRadius.circular(10),
                  ),
            ),
          ),
        ),
        Gap(10),
        Expanded(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset('assets/images/google.svg'),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accentColor),
                  borderRadius: BorderRadius.circular(10),
                  ),
            ),
          ),
        ),
        Gap(10),
        Expanded(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: EdgeInsets.all(15),
              child: SvgPicture.asset('assets/images/apple.svg'),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.accentColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
