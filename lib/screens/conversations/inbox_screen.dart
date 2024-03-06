import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/screens/conversations/bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: CustomAppBar(
          title: "Ali Akbar",
          titleSpace: 10,
          actions: <Widget>[
            RoundedButton(
              title: AppStrings.closeChat,
              onPressed: () {},
              width: 111,
              height: 34,
              textSize: 12,
            )
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 27, vertical: 23),
        child: Column(
          children: <Widget>[
            Expanded(
              child: BubbleWidget(),
            ),
            gapH10,
            MessageTextField(),
          ],
        ),
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  const MessageTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        maxLines: 4,
        minLines: 1,
        clipBehavior: Clip.hardEdge,
        style: StyleGuide.textStyle3.copyWith(color: const Color(0xFF2C2C2C)),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFECEBEB),
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(54)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFECEBEB),
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(54)),
          ),
          hintText: "Send a message",
          hintStyle:
              StyleGuide.textStyle3.copyWith(color: const Color(0xFFBFBFBF)),
          prefixIcon: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: SvgPicture.asset(Assets.clipBoardIcon),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                Icons.send,
                color: StyleGuide.primaryColor2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
