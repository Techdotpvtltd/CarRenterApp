import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(60),
      //     child: CustomAppBar(
      //       title: "Profile",
      //     )),
      body: SafeArea(
          child: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 40),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const SizedBox(
                        width: 110,
                        height: 110,
                        child: Center(
                          child: SizedBox(
                            width: 99,
                            height: 99,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage("assets/images/boy.png"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 25,
                        child: Container(
                          width: 23,
                          height: 23,
                          decoration: const BoxDecoration(
                            color: StyleGuide.primaryColor2,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(Assets.cameraIcon),
                          ),
                        ),
                      ),
                    ],
                  ),
                  gapH18,
                  CustomTitleTextField(
                    fieldText: "Name",
                    hintText: "Jenifer Alex",
                    suffixWidget: IconButton(
                      icon: SvgPicture.asset(
                        Assets.penIcon,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  gapH24,
                  CustomTitleTextField(
                    fieldText: "Phone Number",
                    hintText: "+1 64 012 3456",
                    keyboardType: TextInputType.phone,
                    prefixWidget: IconButton(
                      icon: Image.asset(
                        Assets.flagIcon,
                        fit: BoxFit.fill,
                      ),
                      onPressed: () {},
                    ),
                    suffixWidget: IconButton(
                      icon: SvgPicture.asset(
                        Assets.penIcon,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  gapH24,
                  CustomTitleTextField(
                    fieldText: "Email",
                    hintText: "gdauflck@gmailcom",
                    keyboardType: TextInputType.emailAddress,
                    suffixWidget: IconButton(
                      icon: SvgPicture.asset(
                        Assets.penIcon,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  gapH20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Change Location",
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: StyleGuide.textColor2,
                        ),
                      ),
                      gapH20,
                      Image.asset(Assets.demoMap),
                    ],
                  ),
                  const Spacer(),
                  gapH30,
                  RoundedButton(title: "Save", onPressed: () {})
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
