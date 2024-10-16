import 'package:flutter/material.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';

class ListTileDashBoard extends StatelessWidget {
  ListTileDashBoard({
    required this.listTileTitle,
    required this.listTileSubtitle,
    required this.imagePathTrailing,
    super.key,
  });
  String listTileTitle;
  String imagePathTrailing;
  String listTileSubtitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.white70,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            listTileTitle,
            style: TextStyleHelper.textStylefontSize22
                .copyWith(color: ColorHelper.purple),
          ),
          subtitle: Text(listTileSubtitle,
              style: TextStyleHelper.textStylefontSize14),
          trailing: Image(image: AssetImage(imagePathTrailing)),
        ),
      ),
    );
  }
}
