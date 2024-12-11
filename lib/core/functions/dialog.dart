
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

showErrorDialog (BuildContext context , String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text(text)),
    backgroundColor: AppColors.primaryColor,
    ),
  );
}
// loading ..... should pop after using it because it deal with it as screen .
showLoadingDialog(BuildContext context){
  showDialog(context: context, builder: (context)=>const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: AppColors.primaryColor,
    ),
  ));
}