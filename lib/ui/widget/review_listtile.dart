import 'package:flutter/material.dart';

import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/widget/rating_bar.dart';

// ignore: must_be_immutable
class ReviewListTile extends StatelessWidget {
  ReviewListTile({
    super.key,
    required this.imagePath,
    required this.listTileTitle,
    required this.rating,
    required this.dateReview,
    required this.listTileSubtitle,
  });
  String imagePath;
  String listTileTitle;
  double rating;
  String dateReview;
  String listTileSubtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(imagePath)),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(listTileTitle,
              style: TextStyleHelper.textStylefontSize15
                  .copyWith(color: Colors.black)),
          CustomRatingBar(rating: rating),
        ],
      ),
      subtitle:
          Text(listTileSubtitle, style: TextStyleHelper.textStylefontSize12),
      trailing: Text(dateReview, style: TextStyleHelper.textStylefontSize14),
    );
  }
}
