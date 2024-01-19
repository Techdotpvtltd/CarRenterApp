import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/search_widget.dart';
import 'package:beasy/views/conversations/inbox_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: CustomAppBar(
            isVisible: false,
            title: AppStrings.messages,
            titleSpace: 10,
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 31, left: 21, right: 21, bottom: 2),
          child: Column(
            children: [
              const SearchWidget(
                hintText: AppStrings.searchChats,
              ),
              gapH18,
              Expanded(
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        NavigationService.go(context, const InboxScreen()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(11, 15, 7, 15),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage("assets/images/boy.png"),
                                ),
                                gapW14,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Daniel Atkins",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: Assets.plusJakartaFont,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      gapH6,
                                      Text(
                                        "The weather will be perfect for the st The weather will be perfect for the st",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: Assets.plusJakartaFont,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xFF7A7A7A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                gapW20,
                              ],
                            ),
                            gapH2,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(Assets.doubleCheckIc),
                                gapW8,
                                const Text(
                                  "2:14 PM",
                                  style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    fontFamily: Assets.plusJakartaFont,
                                  ),
                                ),
                                gapW8,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
