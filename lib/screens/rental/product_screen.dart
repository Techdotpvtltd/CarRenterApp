import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/constants.dart';
import 'components/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.products});
  final List<ProductModel> products;

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
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: ProductCard(
                product: products[index],
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
