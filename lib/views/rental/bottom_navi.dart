import 'package:beasy/bloc/rental/rental_bloc.dart';
import 'package:beasy/bloc/rental/rental_event.dart';
import 'package:beasy/bloc/rental/rental_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/views/rental/rental_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavUser extends StatefulWidget {
  const BottomNavUser({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BottomNavWalkState createState() => _BottomNavWalkState();
}

class _BottomNavWalkState extends State<BottomNavUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<RentalBloc>().add(RentalEventInitialize());

    return BlocConsumer<RentalBloc, RentalState>(
      builder: (context, state) {
        return const _BottomNavWidget();
      },
      listener: (context, state) {},
      buildWhen: (previous, current) {
        return false;
      },
    );
  }
}

class _BottomNavWidget extends StatefulWidget {
  const _BottomNavWidget({super.key});

  @override
  State<_BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<_BottomNavWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: SalomonBottomBar(
              backgroundColor: Colors.white,
              selectedColorOpacity: 1,
              selectedItemColor: const Color(0xffFEAF75),
              itemPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              currentIndex: _currentIndex,
              onTap: (i) {
                setState(() {
                  _currentIndex = i;
                });
              },
              items: [
                SalomonBottomBarItem(
                  unselectedColor: Colors.transparent,
                  icon: Image.asset("assets/icons/n1.png",
                      height: 22,
                      color: _currentIndex == 0
                          ? Colors.white
                          : const Color(0xffAEAEAE)),
                  title: const Text(
                    "Home",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: StyleGuide.textColor1,
                    ),
                  ),
                  selectedColor: StyleGuide.primaryColor,
                ),
                SalomonBottomBarItem(
                  unselectedColor: Colors.transparent,
                  icon: Image.asset("assets/icons/n2.png",
                      height: 22,
                      color: _currentIndex == 1
                          ? Colors.white
                          : const Color(0xffAEAEAE)),
                  title: const Text(
                    "Chat",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: StyleGuide.textColor1,
                    ),
                  ),
                  selectedColor: StyleGuide.primaryColor,
                ),
                SalomonBottomBarItem(
                  unselectedColor: Colors.transparent,
                  icon: Image.asset(
                    "assets/icons/n3.png",
                    height: 22,
                    color: _currentIndex == 2
                        ? Colors.white
                        : const Color(0xffAEAEAE),
                    colorBlendMode: BlendMode.srcIn,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: StyleGuide.textColor1,
                    ),
                  ),
                  selectedColor: StyleGuide.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _currentIndex == 0
          ? const RentalHomeScreen()
          : _currentIndex == 1
              ? const RentalHomeScreen()
              : const RentalHomeScreen(),
    );
  }
}
