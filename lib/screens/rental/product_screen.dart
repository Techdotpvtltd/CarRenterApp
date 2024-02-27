import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/screens/rental/components/product_card.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          title: AppStrings.availableNearYour,
          actions: [
            Image.asset(
              "assets/icons/draw.png",
              color: Colors.black,
              height: 12,
              width: 12,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: ProductCard(
                width: screenWidth,
                height: screenHeight * 0.22,
                isLargeCard: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
