import 'package:flutter/material.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/widget/custom_row.dart';
import 'package:providerapp/ui/widget/shared_widget/custom_elevated_button.dart';

class BookingSummary {
  Future<void> _dialogBuilder(BuildContext context, String imagePath) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Container(
                color: ColorHelper.purple,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).BookingSummary),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear_rounded))
                    ]),
              ),
              content: Column(
                children: [
                  Image(image: NetworkImage(imagePath)),
                  const SizedBox(
                    height: 10,
                  ),
                  PaymentRow(
                    paymentRowText: "textBooking_ar",
                    bookingId: "id",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).date,
                    bookingId: "3-5",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).Time,
                    bookingId: "10am",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).Loction,
                    bookingId: "11lljd",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).ServiceStatus,
                    bookingId: "Pending",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).Quantity,
                    bookingId: "1",
                    rowColor: ColorHelper.darkgrey,
                  ),
                  PaymentRow(
                    paymentRowText: S.of(context).Status,
                    bookingId: "pending",
                    rowColor: ColorHelper.darkgrey,
                  ),
                ],
              ),
              actions: <Widget>[
                CustomElevatedButton(
                    buttonText: S.of(context).confirm,
                    onPressedFunction: () {},
                    backColor: ColorHelper.purple,
                    fontColor: Colors.white),
              ]);
        });
  }
}
