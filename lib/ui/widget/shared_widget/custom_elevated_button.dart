import 'package:flutter/material.dart';
import 'package:providerapp/helper/text_style_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.buttonText,
      required this.onPressedFunction,
      required this.backColor,
      required this.fontColor,
      this.buttonWidget = const SizedBox(
        width: 1,
      ),
      this.sideColor,
      this.fontWeight = FontWeight.normal,
      this.textSize = 16,
      this.alignButton = MainAxisAlignment.center,
      this.widthButton = double.infinity});
  final String buttonText;
  final Widget? buttonWidget;
  final double textSize;
  final Color backColor;
  final Color fontColor;
  late Color? sideColor;
  final FontWeight fontWeight;
  final double widthButton;
  final Function()? onPressedFunction;
  final MainAxisAlignment alignButton;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(widthButton, 55),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: buttonWidget,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            buttonText,
            style: TextStyleHelper.textStylefontSize20.copyWith(
                fontWeight: FontWeight.bold,
                color: fontColor,
                fontSize: textSize),
          ),
        ],
      ),
    );
  }
}
