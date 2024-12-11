import 'package:booki_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 41,
          width: 41,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.whiteColor,
          ),
          child: Icon(Icons.arrow_back_ios_new,
          size: 19,
          ),
        ),
      ),
    );
  }
}
