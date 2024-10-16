import 'package:flutter/material.dart';

import 'package:providerapp/helper/text_style_helper.dart';

// ignore: must_be_immutable
class PaymentRow extends StatelessWidget {
  PaymentRow({
    super.key,
    required this.bookingId,
    required this.paymentRowText,
    required this.rowColor,
  });

  final String bookingId;
  String paymentRowText;
  Color rowColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymentRowText,
            style: TextStyleHelper.textStylefontSize18.copyWith(
              fontWeight: FontWeight.normal,
              //   color: Colors.black
            ),
          ),
          Text(
            bookingId,
            style: TextStyleHelper.textStylefontSize18
                .copyWith(fontWeight: FontWeight.normal, color: rowColor),
          ),
        ],
      ),
    );
  }
}
