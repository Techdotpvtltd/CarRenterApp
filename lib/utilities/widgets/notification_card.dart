import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:flutter/material.dart';

import '../constants/asstes.dart';
import '../constants/constants.dart';
import '../constants/style_guide.dart';
import 'rounded_button.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isRentalUser = UserRepo().user.userType == UserType.rentalUser;
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
                const CircleAvatar(
                  radius: 14,
                  backgroundImage: AssetImage(Assets.userImage),
                ),
                gapW8,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Request Accepted",
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
                          const Flexible(
                            child: Text(
                              "Your booking request have been accepted",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                          const Text(
                            "33 mins ago",
                            style: TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: StyleGuide.textColor2),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text(
                            "17/03/2024",
                            style: TextStyle(
                              color: StyleGuide.textColor2,
                              fontFamily: Assets.plusJakartaFont,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          gapW8,
                          Text(
                            "9:00PM to 12:00AM",
                            style: TextStyle(
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
