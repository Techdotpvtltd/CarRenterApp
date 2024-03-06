import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    this.width,
    this.height,
    this.isLargeCard = false,
    this.didHeartPressed,
    required this.product,
  });

  final double? width;
  final double? height;
  final bool isLargeCard;
  final Function(bool)? didHeartPressed;
  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: StyleGuide.backgroundColor2,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  height: constraints.maxHeight * 0.65,
                  width: (constraints.maxWidth),
                  imageUrl: widget.product.images.firstOrNull ?? "",
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: Assets.plusJakartaFont,
                          fontWeight: widget.isLargeCard
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: widget.isLargeCard ? 14.4 : 12,
                          color: StyleGuide.textColor2,
                        ),
                      ),
                      gapH6,
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "\$ ${widget.product.price}",
                              style: TextStyle(
                                fontFamily: Assets.plusJakartaFont,
                                fontSize: widget.isLargeCard ? 13.44 : 12.87,
                                fontWeight: FontWeight.w700,
                                color: StyleGuide.primaryColor2,
                              ),
                              children: [
                                TextSpan(
                                  text: " /Day",
                                  style: TextStyle(
                                    fontSize: widget.isLargeCard ? 8.96 : 8.58,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6B6B6B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                Assets.starIcon,
                                width: widget.isLargeCard ? 15.36 : 12,
                                height: widget.isLargeCard ? 15.36 : 12,
                              ),
                              gapW4,
                              Text(
                                "4.1",
                                style: TextStyle(
                                  fontSize: widget.isLargeCard ? 11.52 : 9,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF626771),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 6,
              right: 8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isFav = !_isFav;
                    if (widget.didHeartPressed != null) {
                      widget.didHeartPressed!(_isFav);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    _isFav ? Assets.heartFillIcon : Assets.heartIcon,
                    width: widget.isLargeCard ? 14 : 8,
                    height: widget.isLargeCard ? 14 : 8,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
