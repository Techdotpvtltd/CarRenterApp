import 'package:beasy/blocs/service_provider/sp_bloc.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/notification_card.dart';
import 'package:beasy/screens/conversations/chat_screen.dart';
import 'package:beasy/screens/common/notification_screen.dart';
import 'package:beasy/screens/service_provider/create_services_screen.dart';
import 'package:beasy/screens/service_provider/my_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../blocs/drawer/drawer_cubit.dart';

class SPHomeScreen extends StatelessWidget {
  const SPHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SPBloc, SPState>(
      listener: (context, state) {},
      child: BackgroundWidget(
        topWidget: Column(
          children: [
            CustomAppBar(
              prefixWidet: Image.asset(
                "assets/icons/draw.png",
                height: 12,
                width: 12,
              ),
              onPressedPrefix: () {
                context.read<DrawerCubit>().openDrawer();
              },
              title: "Hey, 👋 Jenifer Alex ",
              isCenteredTitle: true,
              titleColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {
                    NavigationService.go(
                        context,
                        const ChatScreen(
                          isShowAppBar: true,
                        ));
                  },
                  icon: SvgPicture.asset(
                    Assets.chatIcon,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    NavigationService.go(context,
                        const NotificationScreen(isEnableBackButton: true));
                  },
                  icon: SvgPicture.asset(
                    Assets.bellIcon,
                  ),
                ),
              ],
            ),
            gapH20,
          ],
        ),
        bottomWidget: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _SPHomeCard(
                    title: AppStrings.createService,
                    subTitle: AppStrings.addNew,
                    iconPath: Assets.roundPlusIcon,
                    isSelected: false,
                    onPressed: () => NavigationService.go(
                      context,
                      const CreateServiceScreen(),
                    ),
                  ),
                  _SPHomeCard(
                    title: AppStrings.myService,
                    subTitle: "12",
                    iconPath: Assets.miniCarIcon,
                    isSelected: true,
                    onPressed: () => NavigationService.go(
                      context,
                      const MyServicesScreen(),
                    ),
                  ),
                  _SPHomeCard(
                    title: AppStrings.messages,
                    subTitle: "2 ${AppStrings.newMessage}s",
                    iconPath: Assets.messageIcon,
                    isSelected: false,
                    onPressed: () => NavigationService.go(
                      context,
                      const ChatScreen(
                        isShowAppBar: true,
                      ),
                    ),
                  ),
                ],
              ),
              gapH14,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.quickNotification,
                    style: StyleGuide.serviceProviderStyle1.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      NavigationService.go(
                        context,
                        const NotificationScreen(
                          isEnableBackButton: true,
                        ),
                      );
                    },
                    child: Text(
                      AppStrings.seeAll,
                      style: StyleGuide.serviceProviderStyle1.copyWith(
                        fontWeight: FontWeight.w500,
                        color: StyleGuide.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              gapH8,
              Expanded(
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      child: NotificationCard(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SPHomeCard extends StatelessWidget {
  const _SPHomeCard({
    required this.isSelected,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });
  final bool isSelected;
  final String iconPath;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: screenWidth * 0.276,
        decoration: BoxDecoration(
          color:
              isSelected ? StyleGuide.primaryColor2 : const Color(0xFFF3F4F9),
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Assets.rotatedUpWardIcon,
                    width: 12,
                    height: 12,
                    colorFilter: ColorFilter.mode(
                        isSelected ? StyleGuide.primaryColor2 : Colors.white,
                        BlendMode.srcIn),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        isSelected ? Colors.white : StyleGuide.primaryColor2),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  iconPath,
                  height: 22,
                ),
                gapH6,
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : StyleGuide.textColor2,
                    fontFamily: Assets.poppinsFont,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                gapH2,
                Text(
                  subTitle,
                  style: TextStyle(
                    color: isSelected ? Colors.white : StyleGuide.textColor2,
                    fontFamily: Assets.poppinsFont,
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
