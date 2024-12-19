import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:flutter/material.dart';
class CustomListtile extends StatelessWidget {
  final String? text;
  final Function()onPressed;
   const CustomListtile({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.accentColor,
      shadowColor: AppColors.greyColor.withOpacity(.3),
      elevation: 3,
      child: ListTile(
        leading: Text(text!,style: getSubTitleTextStyle(),),
        trailing: IconButton(onPressed: onPressed, icon:const Icon(Icons.arrow_forward_ios_outlined)),
      ),
    );
  }
}
