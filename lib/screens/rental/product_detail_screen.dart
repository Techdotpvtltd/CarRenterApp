import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _pageController = PageController(initialPage: 0, keepPage: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * .32,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(64),
                      bottomRight: Radius.circular(51),
                    ),
                    child: Image.asset(
                      Assets.demoCar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                child: SafeArea(
                  child: SizedBox.fromSize(
                    size: const Size(27, 27),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        NavigationService.back(context);
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        iconSize: MaterialStatePropertyAll(16),
                        iconColor: MaterialStatePropertyAll(Colors.black),
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 13,
                right: 0,
                left: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: const WormEffect(
                      dotWidth: 7.5,
                      dotHeight: 7.5,
                      activeDotColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 32),
              child: CustomScrollView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Bentley Luxury Car",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: StyleGuide.productCardStyle1.copyWith(
                                  fontSize: 21,
                                  color: const Color(0xFF414141),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$ 24.00/Hour",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleGuide.productCardStyle1.copyWith(
                                    fontSize: 16,
                                    color: const Color(0xFF414141),
                                  ),
                                ),
                                gapH10,
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.starIcon,
                                      width: 12,
                                      height: 12,
                                    ),
                                    gapW4,
                                    Text(
                                      "5.0 (12K Reviews)",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          StyleGuide.productCardStyle1.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF9CA4AB),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                            ),
                            gapW10,
                            Text(
                              AppStrings.bookingHours,
                              style: TextStyle(
                                fontFamily: Assets.poppinsFont,
                                fontSize: 7.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9CA4AB),
                              ),
                            )
                          ],
                        ),
                        gapH12,
                        DottedBorder(
                          padding: const EdgeInsets.all(5),
                          color: const Color(0xFFE2E3E8),
                          strokeWidth: 1,
                          dashPattern: const [4, 4],
                          radius: const Radius.circular(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today, 01:00 PM - 02:00 PM",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.primaryColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 26,
                                height: 26,
                                child: IconButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        StyleGuide.primaryColor2),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsetsDirectional.zero),
                                  ),
                                  icon: SvgPicture.asset(
                                    Assets.penIcon,
                                    width: 12,
                                    height: 12,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gapH16,
                        Text(
                          AppStrings.specification,
                          style: StyleGuide.textStyle3.copyWith(
                            color: const Color(0xFF272B3B),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        gapH12,
                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            child: ReadMoreText(
                              "Lorem ipsum dolor sit amet consectetur. Lectus consequat euismod diam aliquet nisl quis. Urna arcu nunc consequat vel nulla ornare id quis. Lorem ipsum dolor sit amet consectetur. Lectus consequat euismod diam aliquet nisl quis. Urna arcu nunc consequat vel nulla ornare id quis.",
                              trimLines: 3,
                              trimCollapsedText: AppStrings.readMore,
                              trimExpandedText: " Show Less",
                              style: StyleGuide.textStyle3.copyWith(
                                color: const Color(0xFF9CA4AB),
                              ),
                              moreStyle: StyleGuide.textStyle3
                                  .copyWith(color: StyleGuide.textColor2),
                              lessStyle: StyleGuide.textStyle3
                                  .copyWith(color: StyleGuide.textColor2),
                              trimMode: TrimMode.Line,
                            ),
                          ),
                        ),
                        const SeparateWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.model,
                              style: StyleGuide.textStyle3.copyWith(
                                color: StyleGuide.textColor2,
                              ),
                            ),
                            Text(
                              "The Betayge eWB range",
                              style: StyleGuide.textStyle3.copyWith(
                                color: const Color(0xFF414141),
                              ),
                            ),
                          ],
                        ),
                        const SeparateWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.year,
                              style: StyleGuide.textStyle3.copyWith(
                                color: StyleGuide.textColor2,
                              ),
                            ),
                            Text(
                              "2023",
                              style: StyleGuide.textStyle3.copyWith(
                                color: const Color(0xFF414141),
                              ),
                            ),
                          ],
                        ),
                        const SeparateWidget(),
                        Text(
                          AppStrings.bookingZone,
                          style: StyleGuide.textStyle3.copyWith(
                            color: StyleGuide.textColor2,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        gapH12,
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8, top: 9, bottom: 11, right: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFEBEBEB),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(9),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 52,
                                      height: 48,
                                    ),
                                    gapW12,
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.zoneLocation,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: Assets.poppinsFont,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF9CA4AB),
                                            ),
                                          ),
                                          gapH4,
                                          Text(
                                            "Midvalley City",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: Assets.poppinsFont,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: StyleGuide.textColor2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RoundedButton(
                                title: AppStrings.changeLocation,
                                onPressed: () {},
                                width: 90,
                                height: 26,
                                textSize: 9,
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        gapH30,
                        RoundedButton(
                          title: AppStrings.choose,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeparateWidget extends StatelessWidget {
  const SeparateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(
        color: Color(0xFFF5F6FB),
        thickness: 3,
        height: 1,
      ),
    );
  }
}
