import 'package:flutter/material.dart';
import 'package:providerapp/helper/text_style_helper.dart';

class housemanRowDetails extends StatelessWidget {
  housemanRowDetails({
    required this.imagePath,
    required this.housemanDetail,
    super.key,
  });
  String imagePath;
  String housemanDetail;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage(imagePath),
        ),
        Text(housemanDetail, style: TextStyleHelper.textStylefontSize14),
      ],
    );
  }
}
