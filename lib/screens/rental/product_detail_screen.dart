import 'package:beasy/models/product_model.dart';
import 'package:beasy/screens/rental/calendar_screen.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:beasy/utilities/widgets/map_sample.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _pageController = PageController(initialPage: 0, keepPage: false);
  String? bookingLocation;

  void _parseLocationFromCoordinates() async {
    try {
      final List<Placemark> marks = await placemarkFromCoordinates(
          widget.product.latitude, widget.product.longitude);

      final mark = marks.firstOrNull;

      setState(() {
        bookingLocation = "${mark?.locality ?? ""}, ${mark?.country ?? ""}";
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _parseLocationFromCoordinates();
    super.initState();
  }

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
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(64),
                      bottomRight: Radius.circular(51),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: widget.product.images[index],
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
                    count: widget.product.images.length,
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
                                widget.product.name,
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
                                  "\$ ${widget.product.price}/Hour",
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
                        // const Row(
                        //   children: [
                        //     Icon(
                        //       Icons.watch_later_outlined,
                        //     ),
                        //     gapW10,
                        //     Text(
                        //       AppStrings.bookingHours,
                        //       style: TextStyle(
                        //         fontFamily: Assets.poppinsFont,
                        //         fontSize: 7.5,
                        //         fontWeight: FontWeight.w500,
                        //         color: Color(0xFF9CA4AB),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // gapH12,
                        // DottedBorder(
                        //   padding: const EdgeInsets.all(5),
                        //   color: const Color(0xFFE2E3E8),
                        //   strokeWidth: 1,
                        //   dashPattern: const [4, 4],
                        //   radius: const Radius.circular(4),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "Today, 01:00 PM - 02:00 PM",
                        //         style: StyleGuide.textStyle3.copyWith(
                        //           color: StyleGuide.primaryColor2,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 26,
                        //         height: 26,
                        //         child: IconButton(
                        //           onPressed: () {},
                        //           style: const ButtonStyle(
                        //             backgroundColor: MaterialStatePropertyAll(
                        //                 StyleGuide.primaryColor2),
                        //             padding: MaterialStatePropertyAll(
                        //                 EdgeInsetsDirectional.zero),
                        //           ),
                        //           icon: SvgPicture.asset(
                        //             Assets.penIcon,
                        //             width: 12,
                        //             height: 12,
                        //             colorFilter: const ColorFilter.mode(
                        //                 Colors.white, BlendMode.srcIn),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
                          height: widget.product.description == "" ? 0 : 100,
                          child: SingleChildScrollView(
                            child: ReadMoreText(
                              widget.product.description ?? "",
                              trimLength: 100,
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
                              widget.product.model,
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
                              widget.product.year.toString(),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenWidth,
                                height: screenHeight * 0.30,
                                child: MapSample(
                                  isPin: true,
                                  latLng: LatLng(
                                    widget.product.latitude,
                                    widget.product.longitude,
                                  ),
                                ),
                              ),
                              gapH12,
                              const Text(
                                AppStrings.zoneLocation,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Assets.poppinsFont,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9CA4AB),
                                ),
                              ),
                              gapH4,
                              Text(
                                bookingLocation ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: Assets.poppinsFont,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: StyleGuide.textColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        gapH30,
                        RoundedButton(
                          title: AppStrings.choose,
                          onPressed: () => NavigationService.go(
                            context,
                            CalendarScreen(product: widget.product),
                          ),
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
