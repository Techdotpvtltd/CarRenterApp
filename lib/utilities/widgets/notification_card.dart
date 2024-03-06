import 'package:beasy/blocs/data_fetcher/data_fetcher_cubit.dart';
import 'package:beasy/blocs/data_fetcher/data_fetcher_state.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/helping_methods.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constants/asstes.dart';
import '../constants/constants.dart';
import '../constants/style_guide.dart';
import 'rounded_button.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, required this.booking});
  final BookingModel booking;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  void initState() {
    super.initState();
    DataFetcherCubit().scheduleTime();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRentalUser =
        UserRepo().currentUser.userType == UserType.rentalUser;
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF3F4F9),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: CustomNetworkImage(
                    imageUrl: "",
                    width: 30,
                    height: 30,
                  ),
                ),
                gapW8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "---",
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          color: StyleGuide.textColor2,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      gapH4,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "I want to book your ${widget.booking.car} car.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          gapW14,
                          Image.asset(
                            "assets/icons/car.png",
                            height: 23,
                            width: 48,
                            fit: BoxFit.fill,
                          ),
                          gapW10,

                          /// Remaining Time Widgets
                          BlocSelector<DataFetcherCubit, dynamic,
                              DataFetcherTimePeriod?>(
                            selector: (state) => state is DataFetcherTimePeriod
                                ? DataFetcherTimePeriod()
                                : null,
                            builder: (context, state) {
                              return Text(
                                parseTimePeriod(
                                    atTime: widget.booking.createdAt),
                                style: const TextStyle(
                                    fontFamily: Assets.plusJakartaFont,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: StyleGuide.textColor2),
                              );
                            },
                          ),
                        ],
                      ),
                      Text(
                        DateFormat("dd/MM/yyyy")
                            .format(widget.booking.bookingDate),
                        style: const TextStyle(
                          color: StyleGuide.textColor2,
                          fontFamily: Assets.plusJakartaFont,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapH4,
                      BlocSelector<DataFetcherCubit, dynamic,
                          DataFetcherTimePeriod?>(
                        selector: (state) => state is DataFetcherTimePeriod
                            ? DataFetcherTimePeriod()
                            : null,
                        builder: (context, state) {
                          return Text(
                            remainingTime(atTime: widget.booking.bookingDate),
                            style: const TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: StyleGuide.primaryColor),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapH16,
            Center(
              child: isRentalUser
                  ? RoundedButton(
                      title: "Pay now",
                      onPressed: () {},
                      width: 162,
                      height: 32,
                      textSize: 12,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          title: "Reject",
                          onPressed: () {},
                          width: 122,
                          height: 32,
                          textSize: 12,
                          withBorderOnly: true,
                        ),
                        gapW6,
                        RoundedButton(
                          title: "Accept",
                          onPressed: () {},
                          width: 122,
                          height: 32,
                          textSize: 12,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
