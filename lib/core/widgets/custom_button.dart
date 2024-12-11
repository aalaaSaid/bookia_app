import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final Function() onPressed ;
  final double height ;
  final double width ;
  final String text ;
  final Color color ;
  const CustomButton({super.key,
    required this.onPressed ,
    this.height =56,
    this.width =331,
    required this.text,
    this.color= AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height ,
      width: width,
      child: ElevatedButton(onPressed: onPressed,
          child: Text(text , style: getSmallTextStyle(),),
      style: ElevatedButton.styleFrom(
        elevation: 0,
          backgroundColor:color ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),
      ),
    );
  }
}
