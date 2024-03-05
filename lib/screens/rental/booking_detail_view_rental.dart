// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_bloc.dart';
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/blocs/rental/rental_product_bloc.dart';
import 'package:beasy/blocs/rental/rental_product_event.dart';
import 'package:beasy/blocs/rental/rental_product_state.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/screens/rental/calendar_screen.dart';

import 'package:beasy/screens/rental/product_detail_screen.dart';
import 'package:beasy/utilities/extensions/date_extension.dart';
import 'package:beasy/utilities/helping_methods.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/product_model.dart';
import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/constants/style_guide.dart';
import '../../utilities/extensions/navigation_service.dart';
import '../../utilities/widgets/custom_network_image.dart';
import '../../utilities/widgets/map_sample.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_detail_view_rental
/// Path:    	   lib/screens/rental/booking_detail_view_rental.dart
/// Author:       Ali Akbar
/// Date:        05-03-24 12:02:12 -- Tuesday
/// Description:

class BookingDetailViewRentalScreen extends StatefulWidget {
  const BookingDetailViewRentalScreen({super.key, required this.booking});
  final BookingModel booking;
  @override
  State<BookingDetailViewRentalScreen> createState() =>
      _BookingDetailViewRentalScreenState();
}

class _BookingDetailViewRentalScreenState
    extends State<BookingDetailViewRentalScreen> {
  final _pageController = PageController(initialPage: 0, keepPage: false);
  String? bookingLocation;
  bool isExpaned = false;
  late BookingModel bookingModel = widget.booking;
  ProductModel? product;

  void _parseLocationFromCoordinates() async {
    try {
      final List<Placemark> marks = await placemarkFromCoordinates(
          product?.latitude ?? 0, product?.longitude ?? 0);

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
    context
        .read<RentalProductBloc>()
        .add(RentalEventFetchProduct(productId: bookingModel.serviceId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = product != null &&
        bookingModel.bookingTime.last.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch;
    return BlocListener<RentalProductBloc, RentalProductState>(
      listener: (context, state) {
        // if (state is BookingStateBookingUpdated) {
        //   setState(() {
        //     bookingModel = state.booking!;
        //   });
        // }
        if (state is RentalProductStateFetchedProduct) {
          if (state.product != null) {
            setState(() {
              product = state.product;
              _parseLocationFromCoordinates();
            });
          }
        }
      },
      child: Scaffold(
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
                    itemCount: product?.images.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(64),
                        bottomRight: Radius.circular(51),
                      ),
                      child: CustomNetworkImage(
                        imageUrl: product?.images[index] ?? "",
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
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
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
                      count: product?.images.length ?? 1,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 31, vertical: 32),
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
                                  product?.name ?? "---",
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
                                    "\$ ${calculateTotalPrice(bookingModel.bookingTime.first, bookingModel.bookingTime.last, product?.price ?? 0)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        StyleGuide.productCardStyle1.copyWith(
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
                                        style: StyleGuide.productCardStyle1
                                            .copyWith(
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

                          /// Edit time box
                          BlocSelector<BookingBloc, BookingState, BookingModel>(
                              selector: (state) {
                            if (state is BookingStateBookingUpdated) {
                              setState(() {
                                bookingModel = state.booking!;
                              });
                              context
                                  .read<BookingBloc>()
                                  .add(BookingEventInitial());
                              return state.booking!;
                            }

                            return bookingModel;
                          }, builder: (context, state) {
                            return FittedBox(
                              child: DottedBorder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: const Color(0xFFE2E3E8),
                                strokeWidth: 1,
                                dashPattern: const [4, 4],
                                radius: const Radius.circular(4),
                                child: Row(
                                  children: [
                                    Text(
                                      "${isSameDay(bookingModel.bookingDate, DateTime.now()) ? "Today" : bookingModel.bookingDate.dateToString("dd-MMM-yy")}, ${bookingModel.bookingTime.first.dateToString("hh:mm a")} - ${bookingModel.bookingTime.last.dateToString("hh:mm a")}",
                                      style: StyleGuide.textStyle3.copyWith(
                                        color: StyleGuide.primaryColor2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    gapW20,
                                    Visibility(
                                      visible: isAvailable,
                                      child: SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: IconButton(
                                          onPressed: () => NavigationService.go(
                                            context,
                                            CalendarScreen(
                                              product: product!,
                                              booking: bookingModel,
                                            ),
                                          ),
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          gapH16,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                ),
                              ),
                              Text(
                                bookingModel.status.text,
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
                                "Total hours:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                ),
                              ),
                              Text(
                                parseTotalHours(bookingModel.bookingTime.first,
                                    bookingModel.bookingTime.last),
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
                                "Price:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                ),
                              ),
                              Text(
                                "\$ ${product?.price ?? 0}/Hour",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: const Color(0xFF414141),
                                ),
                              ),
                            ],
                          ),
                          const SeparateWidget(),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                flex: 10,
                                child: Text(
                                  product?.description ?? "",
                                  style: StyleGuide.textStyle3.copyWith(
                                    color: const Color(0xFF9CA4AB),
                                  ),
                                  maxLines: isExpaned ? null : 4,
                                ),
                              ),
                              Visibility(
                                visible: product?.description != "" &&
                                    (product?.description?.length ?? 0) > 50,
                                child: Flexible(
                                  flex: 2,
                                  child: Text.rich(
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            isExpaned = !isExpaned;
                                          });
                                        },
                                      text: isExpaned ? "Less" : "More",
                                      style: StyleGuide.textStyle3.copyWith(
                                          color: StyleGuide.textColor2),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                product?.model ?? "---",
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
                                product?.year.toString() ?? "---",
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
                                      product?.latitude ?? 0,
                                      product?.longitude ?? 0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
