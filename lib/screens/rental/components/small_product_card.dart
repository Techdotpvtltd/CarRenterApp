import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/round_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallProductCard extends StatelessWidget {
  const SmallProductCard({
    super.key,
    required this.url,
    required this.title,
    this.price,
    this.rating,
    this.distance,
    this.status,
    this.bottomWidget,
  });
  final String url;
  final String title;
  final double? price;
  final double? rating;
  final String? distance;
  final String? status;
  final Widget? bottomWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.fromLTRB(11, 12, 20, 10),
          decoration: const BoxDecoration(
            color: StyleGuide.backgroundColor2,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const RoundImageWidget(
                    imageUrl: Assets.demoCar,
                    width: 81,
                    height: 81,
                  ),
                  gapW10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: StyleGuide.productCardStyle1.copyWith(
                            fontSize: 14,
                            color: StyleGuide.textColor2,
                          ),
                        ),
                        gapH4,
                        Text.rich(
                          TextSpan(
                            text: "\$ $price",
                            children: [
                              TextSpan(
                                text: " /Hour",
                                style: StyleGuide.productCardStyle1.copyWith(
                                  fontSize: 8.9,
                                  color: const Color(0xFF6B6B6B),
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleGuide.productCardStyle1.copyWith(
                            fontSize: 13.33,
                            color: StyleGuide.primaryColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: status != null,
                        child: Column(
                          children: [
                            Container(
                              width: 68,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD4E3FF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  status ?? "",
                                  style: StyleGuide.productCardStyle1.copyWith(
                                    color: StyleGuide.primaryColor,
                                    fontSize: 6,
                                  ),
                                ),
                              ),
                            ),
                            gapH10,
                          ],
                        ),
                      ),
                      Visibility(
                        visible: distance != null,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  Assets.locationIcon,
                                  width: 16,
                                  height: 16,
                                  color: const Color(0xFF868686),
                                ),
                                gapW4,
                                Text(
                                  distance ?? "",
                                  style: StyleGuide.productCardStyle1.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: const Color(0xFF868686),
                                  ),
                                )
                              ],
                            ),
                            gapH16,
                          ],
                        ),
                      ),
                      Visibility(
                        visible: rating != null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(Assets.starIcon),
                            gapW2,
                            Text(
                              rating?.toString() ?? "",
                              style: StyleGuide.productCardStyle1.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 9.4,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              if (bottomWidget != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: bottomWidget!,
                ),
            ],
          ),
        );
      },
    );
  }
}
