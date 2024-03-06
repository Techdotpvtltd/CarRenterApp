import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/constants/constants.dart';
import '../../utilities/constants/style_guide.dart';

class BubbleWidget extends StatelessWidget {
  const BubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Today",
              style: TextStyle(
                color: Color(0xFF7C7C7C),
                fontFamily: Assets.plusJakartaFont,
                fontWeight: FontWeight.w700,
                fontSize: 10,
              ),
            ),
            gapH18,
            _getBubble(MessageType.product),
            gapH26,
            _getBubble(MessageType.textSender),
            gapH26,
            _getBubble(MessageType.textReciever),
            gapH26,
            _getBubble(MessageType.imageSender),
            gapH26,
            _getBubble(MessageType.imageReciever),
            gapH26,
            _getBubble(MessageType.videoSender),
          ],
        ),
      ),
    );
  }
}

Widget _getBubble(MessageType messageType) {
  switch (messageType) {
    case MessageType.product:
      return Container(
        width: screenWidth,
        height: screenHeight * 0.21,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6FB),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  Assets.demoCar,
                  height: constraints.maxHeight * 0.74,
                  width: constraints.maxWidth,
                  fit: BoxFit.fill,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 3),
                  child: Text(
                    "Bentley luxury Car",
                    style: TextStyle(
                      color: StyleGuide.textColor2,
                      fontSize: 14.45,
                      fontWeight: FontWeight.w700,
                      fontFamily: Assets.plusJakartaFont,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

    case MessageType.textReciever:
      return Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: screenWidth * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
                child: Text(
                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly",
                  style: StyleGuide.textStyle3.copyWith(
                    color: const Color(0xFF6B6B6B),
                  ),
                ),
              ),
              gapH6,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(Assets.demoCar),
                      ),
                      gapW6,
                      Text(
                        "Ali Akbar",
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          fontSize: 10.28,
                          fontWeight: FontWeight.w400,
                          color: StyleGuide.textColor2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "09:04 PM",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

    case MessageType.textSender:
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: screenWidth * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: const BoxDecoration(
                  color: StyleGuide.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
                child: Text(
                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly",
                  style: StyleGuide.textStyle3.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              gapH6,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "09:04 PM",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Ali Akbar",
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          fontSize: 10.28,
                          fontWeight: FontWeight.w400,
                          color: StyleGuide.textColor2,
                        ),
                      ),
                      gapW6,
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(Assets.demoCar),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );

    case MessageType.imageSender:
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            color: StyleGuide.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(11),
            ),
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
            child: Stack(
              children: [
                Image.asset(Assets.userImage),
                Positioned(
                  right: 10,
                  bottom: 4,
                  child: Row(
                    children: [
                      const Text(
                        "09:04 PM",
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      gapW6,
                      SvgPicture.asset(Assets.doubleCheckIc),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

    case MessageType.imageReciever:
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey[500],
            borderRadius: const BorderRadius.all(
              Radius.circular(11),
            ),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  Assets.demoCar,
                ),
                const Positioned(
                  left: 10,
                  bottom: 4,
                  child: Text(
                    "09:04 PM",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    default:
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Text(
          "Your app doesn't support this message. Please update the app to see the message.",
          style: TextStyle(
            color: StyleGuide.textColor2,
            fontFamily: Assets.plusJakartaFont,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      );
  }
}

enum MessageType {
  product,
  textSender,
  textReciever,
  imageSender,
  imageReciever,
  videoSender,
  videoReciever,
}
