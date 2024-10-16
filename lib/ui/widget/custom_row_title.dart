import 'package:flutter/material.dart';
import 'package:providerapp/helper/text_style_helper.dart';

class CustomRowTitle extends StatelessWidget {
  CustomRowTitle({
    required this.title,
    required this.title2,
    required this.onPressedFunction,
    super.key,
  });
  String title;
  String title2;
   void Function()? onPressedFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyleHelper.textStylefontSize15),
          TextButton(onPressed: onPressedFunction,
            child:Text( title2, style: TextStyleHelper.textStylefontSize15))
        ],
      ),
    );
  }
}
