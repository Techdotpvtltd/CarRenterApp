import 'package:beasy/bloc/drawer/drawer_cubit.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  int current = 0;
  bool shouldCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: StyleGuide.primaryColor,
        child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  context.read<DrawerCubit>().openDrawer();
                                },
                                child: Image.asset(
                                  "assets/icons/draw.png",
                                  height: 12,
                                )),
                            gapW10,
                            const Text(
                              "Your Booking",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        gapH10,
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xffFAFAFA).withOpacity(0.09),
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      current = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: current == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                            color: current == 0
                                                ? StyleGuide.primaryColor
                                                : Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      current = 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: current == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Ongoing",
                                        style: TextStyle(
                                            color: current == 1
                                                ? StyleGuide.primaryColor2
                                                : Colors.white,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    current = 2;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: current == 2
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Previews",
                                        style: TextStyle(
                                          color: current == 2
                                              ? StyleGuide.primaryColor2
                                              : Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapH10,
                  logIN(index: current)
                ],
              ),
            )),
      ),
    );
  }

  Widget logIN({int? index}) {
    return Container(
      height: 400,
      width: screenWidth,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH4,
            myBooking(
              ongoing: index == 1 ? true : false,
              previous: index == 2 ? true : false,
            )
          ],
        ),
      ),
    );
  }

  Widget myBooking({bool ongoing = false, previous = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF5F6FB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/car.jpg",
                          fit: BoxFit.fill,
                          height: 81,
                          width: 81,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  const Spacer(),
                                  Container(
                                    width: 68,
                                    height: 18,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD4E3FF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ongoing ? "Accepted" : "Completed",
                                        style: const TextStyle(
                                          fontFamily: Assets.plusJakartaFont,
                                          fontSize: 6.88,
                                          fontWeight: FontWeight.w700,
                                          color: StyleGuide.primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              gapH4,
                              Row(
                                children: [
                                  const Text(
                                    "Bentley luxury Car",
                                    style: TextStyle(
                                      fontFamily: Assets.plusJakartaFont,
                                      color: StyleGuide.textColor2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    "assets/icons/pin1.png",
                                    width: 16,
                                    height: 16,
                                  ),
                                  const Text(
                                    " 1.3 km",
                                    style: TextStyle(
                                      fontFamily: Assets.plusJakartaFont,
                                      color: Color(0xff6B6B6B),
                                      fontSize: 13.6,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 1),
                              Row(
                                children: [
                                  const Text(
                                    "\$ 24.00",
                                    style: TextStyle(
                                      fontFamily: Assets.plusJakartaFont,
                                      color: StyleGuide.primaryColor2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "/Hour",
                                    style: TextStyle(
                                        fontFamily: Assets.plusJakartaFont,
                                        color: Color(0xff6B6B6B),
                                        fontSize: 13.6,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    Assets.starIcon,
                                    width: 12,
                                    height: 12,
                                  ),
                                  gapW4,
                                  const Text(
                                    "4.8",
                                    style: TextStyle(
                                      fontFamily: Assets.plusJakartaFont,
                                      color: Color(0xff6B6B6B),
                                      fontSize: 14.6,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1.5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  ongoing
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(
                              color: Color(0xffCFCFCF),
                              thickness: 2,
                            ),
                            const SizedBox(height: 1),
                            const Text(
                              "Picking Time",
                              style: TextStyle(
                                fontSize: 13.5,
                                fontFamily: Assets.plusJakartaFont,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5C5C5C),
                              ),
                            ),
                            gapH8,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/date.png",
                                      height: 33,
                                    ),
                                    gapW10,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.36,
                                          child: const Text(
                                            "8:00-9:00 AM,  09 Dec",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily:
                                                  Assets.plusJakartaFont,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: StyleGuide.textColor2,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 0.4),
                                        const Text(
                                          "Schedule",
                                          style: TextStyle(
                                            fontSize: 12.8,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: Assets.plusJakartaFont,
                                            color: Color(0xff5C5C5C),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                RoundedButton(
                                  title: "Message",
                                  onPressed: () {},
                                  width: 120,
                                  height: 40,
                                )
                              ],
                            ),
                          ],
                        )
                      : const SizedBox(),
                  previous
                      ? Column(
                          children: [
                            const Divider(
                              color: Color(0xffCFCFCF),
                              thickness: 2,
                            ),
                            const SizedBox(height: 1),
                            gapH18,
                            RoundedButton(
                              title: "Write Review",
                              onPressed: () {},
                              width: 120,
                              height: 40,
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
