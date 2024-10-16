import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:providerapp/controller/booking/booking_cubit.dart';
import 'package:providerapp/controller/booking/booking_state.dart';
import 'package:providerapp/generated/l10n.dart';
import 'package:providerapp/helper/color_helper.dart';
import 'package:providerapp/helper/text_style_helper.dart';
import 'package:providerapp/ui/widget/booking_history_indicator.dart';

// ignore: must_be_immutable
class BookingHistoryTimeline extends StatelessWidget {
  BookingHistoryTimeline({
    super.key,
    required this.bookingId,
  });
  String bookingId;

  @override

  // final List<BookingHistory> bookingHistory = [
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).BookingHistory,
                    style: TextStyleHelper.textStylefontSize18),
                Text(bookingId,
                    style: TextStyleHelper.textStylefontSize16.copyWith(
                        color: ColorHelper.purple,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 300,
              child: BlocBuilder<BookingCubit, BookingStatus>(
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is Bookingloaded) {
                    final booking = (state).bookingList;

                    return ListView(children: [
                      BookingHistoryEntryWidget(
                        bookingList: booking,
                        index: 0,
                      ),
                    ]);

                    // ListView.builder(
                    //   itemCount: booking.length,
                    //   itemBuilder: (context, index) {
                    //     if (booking[index].bookingId == bookingId) {
                    //       return BookingHistoryEntryWidget(
                    //         bookingList: booking,
                    //         index: index,
                    //       );
                    //     }
                    //     return null;
                    //   },
                    // );
                  } else if (state is BookingFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
