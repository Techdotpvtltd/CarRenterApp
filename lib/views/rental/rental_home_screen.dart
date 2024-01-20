import 'package:beasy/bloc/drawer/drawer_cubit.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/rental_home_widgets/product_card.dart';
import 'package:beasy/utilities/widgets/rental_home_widgets/product_section_widget.dart';
import 'package:beasy/utilities/widgets/search_widget.dart';
import 'package:beasy/views/rental/product_screen.dart';
import 'package:beasy/views/rental/search_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentalHomeScreen extends StatefulWidget {
  const RentalHomeScreen({super.key});

  @override
  State<RentalHomeScreen> createState() => _RentalHomeScreenState();
}

class _RentalHomeScreenState extends State<RentalHomeScreen> {
  int _selectedBrand = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      innerWidget: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 30),
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
                      height: 16,
                    )),
                const Spacer(),
                Image.asset(
                  "assets/icons/pin2.png",
                  height: 16,
                ),
                gapW10,
                const Text(
                  "Ngangklik,Sleman",
                  style: TextStyle(
                    fontFamily: Assets.plusJakartaFont,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: StyleGuide.textColor1,
                  ),
                ),
                const Spacer(),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/images/boy.png"),
                ),
              ],
            ),
            gapH32,
            const Text(
              "Pic up Your favorite\nCar for rent.",
              style: TextStyle(
                color: StyleGuide.textColor1,
                fontFamily: Assets.poppinsFont,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
      mediumWidget: SearchWidget(
        hintText: AppStrings.searchVechile,
        onSubmitted: (str) => NavigationService.go(
            context,
            SearchProductScreen(
              searchText: str,
            )),
        shadows: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withAlpha(25),
            spreadRadius: 0,
          ),
        ],
      ),
      outerWidget: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 56, 28, 90),
          child: Column(
            children: [
              ProductSectionWidget(
                title: AppStrings.topBrands,
                itemCount: 10,
                cardHeight: 40,
                onPressedAll: () {},
                onPressedProduct: (index) {
                  setState(() {
                    _selectedBrand = index;
                  });
                },
                builder: (index) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 23,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedBrand == index
                        ? StyleGuide.primaryColor2
                        : Colors.white,
                    border: Border.all(
                      color: _selectedBrand == index
                          ? StyleGuide.primaryColor
                          : const Color(0xFFBFBFBF),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(78)),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.bmwIcon,
                        height: 21,
                        width: 21,
                        fit: BoxFit.contain,
                      ),
                      gapW6,
                      Text(
                        "BMW",
                        style: StyleGuide.onboardingText1.copyWith(
                          color: _selectedBrand == index
                              ? Colors.white
                              : StyleGuide.textColor2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              gapH18,
              ProductSectionWidget(
                title: AppStrings.availableNearYour,
                onPressedAll: () {
                  NavigationService.go(context, const ProductScreen());
                },
                itemCount: 5,
                onPressedProduct: (index) {},
                builder: (index) => const ProductCard(
                  width: 167,
                ),
                cardHeight: 170,
              ),
              gapH18,
              ProductSectionWidget(
                title: AppStrings.topDeals,
                onPressedAll: () {
                  NavigationService.go(context, const ProductScreen());
                },
                itemCount: 5,
                onPressedProduct: (index) {},
                builder: (index) => const ProductCard(
                  width: 167,
                ),
                cardHeight: 170,
              )
            ],
          ),
        ),
      ),
    );
  }
}
