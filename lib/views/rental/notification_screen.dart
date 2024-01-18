import 'package:beasy/bloc/drawer/drawer_cubit.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: AppStrings.notifications,
          onPressed: () {
            context.read<DrawerCubit>().openDrawer();
          },
        ),
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(30, 4, 22, 4),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffF3F4F9),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Request Accepted",
                              style: TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                color: StyleGuide.textColor2,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
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
                                      fontWeight: FontWeight.w300,
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
                    child: RoundedButton(
                      title: "Pay now",
                      onPressed: () {},
                      width: 162,
                      height: 32,
                      textSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
