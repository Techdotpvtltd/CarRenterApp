import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:flutter/material.dart';

class ProductSectionWidget extends StatelessWidget {
  const ProductSectionWidget({
    super.key,
    required this.title,
    required this.onPressedAll,
    required this.itemCount,
    required this.onPressedProduct,
    required this.builder,
    required this.cardHeight,
    required this.products,
  });
  final String title;
  final VoidCallback onPressedAll;
  final int itemCount;
  final Function(int index) onPressedProduct;
  final Widget Function(int) builder;
  final double cardHeight;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: Assets.poppinsFont,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: StyleGuide.textColor2,
              ),
            ),
            TextButton(
              onPressed: onPressedAll,
              child: const TextButtonChildWidget(
                text: AppStrings.seeAll,
              ),
            )
          ],
        ),
        gapH14,
        Container(
          constraints: BoxConstraints(maxHeight: cardHeight),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: InkWell(
                  onTap: () => onPressedProduct(index),
                  child: builder(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
