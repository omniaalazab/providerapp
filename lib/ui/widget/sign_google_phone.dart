import 'package:flutter/material.dart';

class SignWithGooglePhoneSizedBox extends StatelessWidget {
  SignWithGooglePhoneSizedBox({
    super.key,
    required this.imagePath,
    required this.onTapFunction,
  });
  String imagePath;
  void Function()? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: InkWell(
        onTap: onTapFunction,
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
