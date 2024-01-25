import 'dart:developer';

import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/views/menu/all_booking.dart';
import 'package:beasy/views/service_provider/sp_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../blocs/drawer/drawer_screen_state.dart';
import '../rental/bottom_navi.dart';
import '../common/notification_screen.dart';

List titles = [
  "Home",
  "Bookings",
  "Notifications",
  "Change Password",
  "Reviews",
  "FAQ’s",
  "Teams & Conditions",
  "Contact us",
];

List images = [
  "assets/icons/dd1.png",
  "assets/icons/dd2.png",
  "assets/icons/dd3.png",
  "assets/icons/dd4.png",
  "assets/icons/dd5.png",
  "assets/icons/dd6.png",
  "assets/icons/dd7.png",
  "assets/icons/dd8.png"
];

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerCubit>(
      create: (context) => DrawerCubit(),
      child: BlocBuilder<DrawerCubit, DrawerScreenState>(
        builder: (context, state) {
          final bloc = context.read<DrawerCubit>();

          return BlocListener<DrawerCubit, DrawerScreenState>(
            listener: (context, state) {
              if (state is DrawerStateToggled) {}
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                    color: Colors.white,
                  )),
                  Positioned.fill(
                    child: Builder(
                      builder: (context) {
                        return Stack(
                          children: [
                            ZoomDrawer(
                                disableDragGesture: true,
                                style: DrawerStyle.defaultStyle,
                                controller: bloc.zoomDrawerController,
                                menuScreen: DrawerScreen(setIndex: (index) {
                                  bloc.setIndex = index;
                                  bloc.setOpen = false;
                                }),
                                mainScreen: Builder(builder: (context) {
                                  return UserRepo().user.userType ==
                                          UserType.rentalUser
                                      ? currentRentalScreen(bloc.currentIndex)
                                      : currentServiceProviderScreen(
                                          bloc.currentIndex);
                                }),
                                borderRadius: 30,
                                showShadow: false,
                                angle: -10.0,
                                slideWidth: screenWidth * 0.55,
                                menuBackgroundColor: Colors.transparent),
                            bloc.open
                                ? Positioned.fill(
                                    child: SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(children: [
                                              InkWell(
                                                onTap: () {
                                                  bloc.closeDrawer();
                                                },
                                                child: const Icon(
                                                    Icons.arrow_back,
                                                    color: Colors.black),
                                              ),
                                              const Spacer(),
                                            ]),
                                            gapH10,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    width: 76,
                                                    height: 76,
                                                    child: CircleAvatar(
                                                      radius: 100,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage: AssetImage(
                                                          "assets/images/boy.png"),
                                                    ),
                                                  ),
                                                  gapH10,
                                                  const Text(
                                                    "Hey, 👋",
                                                    style: TextStyle(
                                                      color:
                                                          StyleGuide.textColor2,
                                                      fontFamily: Assets
                                                          .plusJakartaFont,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18.78,
                                                    ),
                                                  ),
                                                  gapH4,
                                                  SizedBox(
                                                    width: screenWidth * 0.36,
                                                    child: const Text(
                                                      "Alisson becker",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: StyleGuide
                                                            .textColor2,
                                                        fontFamily: Assets
                                                            .plusJakartaFont,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 18.78,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            bloc.open
                                ? Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: SafeArea(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 38.0, vertical: 20),
                                          child: InkWell(
                                            onTap: () {
                                              context.read<AuthBloc>().add(
                                                  AuthEventPerformLogout());
                                            },
                                            child: const Text(
                                              "Sign Out",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget currentServiceProviderScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const SPHomeScreen();
      case 2:
        return const NotificationScreen();
      default:
        return const SPHomeScreen();
    }
  }

  Widget currentRentalScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const BottomNavUser();
      case 1:
        return const AllBookings();
      case 2:
        return const NotificationScreen();
      case 3:
        return const BottomNavUser();
      case 4:
        return const BottomNavUser();
      case 5:
        return const BottomNavUser();
      case 6:
        return const BottomNavUser();
      default:
        return const BottomNavUser();
    }
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerScreen({super.key, required this.setIndex});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: screenHeight * 0.74,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 33),
                          child: ListView.builder(
                            // padding: EdgeInsets.zero,
                            itemCount: titles.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                setState(() {
                                  widget.setIndex(index);
                                  setState(() {
                                    _active = index;
                                  });
                                  log(_active.toString());
                                  if (_active != 3 &&
                                      _active != 5 &&
                                      _active != 6) {
                                    // Get.find<NavController>().isVisible = true;
                                    // Get.find<NavController>().update();
                                  }
                                  ZoomDrawer.of(context)!.close();
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: Container(
                                  height: screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                      // color: _active == index? const Color(0xffFFFFFF).withOpacity(0.13):Colors.transparent,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        images[index],
                                        height: 24,
                                        color: Colors.black,
                                      ),
                                      gapW20,
                                      Flexible(
                                        child: Text(
                                          titles[index],
                                          style: TextStyle(
                                              fontFamily:
                                                  Assets.plusJakartaFont,
                                              fontSize: 14,
                                              fontWeight: _active == index
                                                  ? FontWeight.w600
                                                  : FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MyDrawerController extends GetxController {
//   @override
//   void toggleDrawer() {
//     print("Toggle drawer");
//     Timer(const Duration(microseconds: 30), () {
//       open = true;
//       Get.find<NavController>().isVisible = false;
//       Get.find<NavController>().update();

//       update();
//     });
//     zoomDrawerController.toggle?.call();
//     update();
//   }



// }
