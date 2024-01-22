import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/blocs/drawer/drawer_screen_state.dart';
import 'package:beasy/blocs/rental/rental_product_bloc.dart';
import 'package:beasy/blocs/rental/rental_product_event.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/views/common/profile_screen.dart';
import 'package:beasy/views/conversations/chat_screen.dart';
import 'package:beasy/views/rental/rental_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavUser extends StatelessWidget {
  const BottomNavUser({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<RentalProductBloc>().add(RentalProductEventInitialize());

    return const _BottomNavWidget();
  }
}

class _BottomNavWidget extends StatefulWidget {
  const _BottomNavWidget();

  @override
  State<_BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<_BottomNavWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BlocBuilder<DrawerCubit, DrawerScreenState>(
        builder: (context, state) => Visibility(
          visible: !context.read<DrawerCubit>().open,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, -14),
                  color: Colors.black.withAlpha(10),
                  blurRadius: 64,
                  spreadRadius: 0,
                ),
              ],
            ),
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
      ),
      body: _currentIndex == 0
          ? const RentalHomeScreen()
          : _currentIndex == 1
              ? const ChatScreen()
              : const ProfileScreen(),
    );
  }
}
