import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/helping_methods.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/asstes.dart';
import '../constants/constants.dart';
import '../constants/style_guide.dart';
import 'rounded_button.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.booking});
  final BookingModel booking;

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
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: CustomNetworkImage(
                    imageUrl: booking.bookingUserProfile,
                    width: 30,
                    height: 30,
                  ),
                ),
                gapW8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.bookingUserName,
                        style: const TextStyle(
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
                              "I want to book your ${booking.car} car.",
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
                          Text(
                            parseTimePeriod(atTime: booking.createdAt),
                            style: const TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: StyleGuide.textColor2),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat("dd/MM/yyyy")
                                .format(booking.bookingDate),
                            style: const TextStyle(
                              color: StyleGuide.textColor2,
                              fontFamily: Assets.plusJakartaFont,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          gapW8,
                          Text(
                            "${DateFormat("hh:mm a").format(booking.bookingTime.first)} to ${DateFormat("hh:mm a").format(booking.bookingTime.last)}",
                            style: const TextStyle(
                              color: StyleGuide.textColor2,
                              fontFamily: Assets.plusJakartaFont,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
