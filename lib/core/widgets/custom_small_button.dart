import 'package:flutter/material.dart';
class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key, required this.onpressed});
final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(onPressed: onpressed,
      icon: Icon(Icons.close),
      constraints: BoxConstraints(maxWidth: 24,maxHeight: 24),
      iconSize: 16,
      padding: EdgeInsets.all(2),
    );
  }
}
