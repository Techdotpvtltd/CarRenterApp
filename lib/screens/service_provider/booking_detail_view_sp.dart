// ignore: dangling_library_doc_comments
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/extensions/date_extension.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/booking_model.dart';
import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/constants/style_guide.dart';
import '../../utilities/extensions/navigation_service.dart';
import '../../utilities/widgets/custom_network_image.dart';
import '../../utilities/widgets/map_sample.dart';
import '../../utilities/widgets/rounded_button.dart';
import '../conversations/inbox_screen.dart';
import '../rental/product_detail_screen.dart';

/// Project: 	   CarRenterApp
/// File:    	   booking_detail_view_sp
/// Path:    	   lib/screens/service_provider/booking_detail_view_sp.dart
/// Author:       Ali Akbar
/// Date:        07-03-24 12:06:28 -- Thursday
/// Description:

class BookingDetailViewSP extends StatefulWidget {
  const BookingDetailViewSP({super.key, required this.booking, this.userModel});
  final BookingModel booking;
  final UserModel? userModel;

  @override
  State<BookingDetailViewSP> createState() => _BookingDetailViewSPState();
}

class _BookingDetailViewSPState extends State<BookingDetailViewSP> {
  String? bookingLocation;
  late final UserModel? user = widget.userModel;
  late final ProductModel? product = ImmutableProductRepo()
      .products
      .where((element) => element.id == widget.booking.serviceId)
      .firstOrNull;
  void _parseLocationFromCoordinates() async {
    try {
      final List<Placemark> marks = await placemarkFromCoordinates(
          user?.location.latitude ?? 0, user?.location.longitude ?? 0);

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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(title: "Booking Detail"),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, top: 24, right: 30, bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Avatar, Title and Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      child: CustomNetworkImage(
                                        imageUrl: user?.imageUrl ?? "",
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    gapW10,
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${user?.firstName} ${user?.lastName}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: StyleGuide.productCardStyle1
                                                .copyWith(
                                              fontSize: 24,
                                              color: const Color(0xFF414141),
                                            ),
                                          ),
                                          // Rating View
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.starIcon,
                                                width: 12,
                                                height: 12,
                                              ),
                                              gapW4,
                                              const Text(
                                                "4.8",
                                                style: TextStyle(
                                                  fontFamily:
                                                      Assets.plusJakartaFont,
                                                  color: Color(0xff6B6B6B),
                                                  fontSize: 14.6,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              gapW4,
                              IconButton(
                                icon: const Icon(Icons.message),
                                onPressed: () {
                                  NavigationService.go(
                                      context, const InboxScreen());
                                },
                                style: const ButtonStyle(
                                  padding:
                                      MaterialStatePropertyAll(EdgeInsets.zero),
                                  iconColor: MaterialStatePropertyAll(
                                      StyleGuide.primaryColor),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(
                                      color: StyleGuide.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          gapH16,
                          const SeparateWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.booking.status.text,
                                style: StyleGuide.textStyle3.copyWith(
                                  color: Color(widget.booking.status.colorCode),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SeparateWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking Date:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                isSameDay(widget.booking.bookingDate,
                                        DateTime.now())
                                    ? "Today"
                                    : widget.booking.bookingDate
                                        .dateToString("dd-MMMM-yy"),
                                style: StyleGuide.textStyle3.copyWith(
                                  color: const Color(0xFF414141),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SeparateWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Request Date:",
                                style: StyleGuide.textStyle3.copyWith(
                                  color: StyleGuide.textColor2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                isSameDay(widget.booking.createdAt,
                                        DateTime.now())
                                    ? "Today"
                                    : widget.booking.createdAt
                                        .dateToString("dd-MMM-yy hh:mm a"),
                                style: StyleGuide.textStyle3.copyWith(
                                  color: const Color(0xFF414141),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SeparateWidget(),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Model:",
                                  style: StyleGuide.textStyle3.copyWith(
                                    color: StyleGuide.textColor2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "${product?.name ?? "-"} - ${product?.model ?? "-"}",
                                    maxLines: 1,
                                    style: StyleGuide.textStyle3.copyWith(
                                      color: const Color(0xFF414141),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                                      user?.location.latitude ?? 0,
                                      user?.location.longitude ?? 0,
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

              gapH20,

              /// Bottom Buttons
              Visibility(
                visible: widget.booking.cancelationDate == null &&
                    widget.booking.status == BookingStatus.pending,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RoundedButton(
                        title: "Reject",
                        onPressed: () {},
                        height: 45,
                        textSize: 14,
                        withBorderOnly: true,
                        buttonColor: Color(BookingStatus.rejected.colorCode),
                      ),
                    ),
                    gapW10,
                    Flexible(
                      child: RoundedButton(
                        title: "Accept",
                        onPressed: () {},
                        height: 45,
                        textSize: 14,
                        buttonColor: Color(BookingStatus.accepted.colorCode),
                      ),
                    ),
                  ],
                ),
              ),

              /// On Going and Completed
              Visibility(
                visible: widget.booking.cancelationDate == null &&
                    widget.booking.status == BookingStatus.paid,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: widget.booking.cancelationDate == null &&
                          widget.booking.status == BookingStatus.paid,
                      child: Flexible(
                        child: RoundedButton(
                          title: "Mark On-Going",
                          onPressed: () {},
                          height: 45,
                          textSize: 14,
                          withBorderOnly: true,
                          buttonColor: Color(BookingStatus.ongoing.colorCode),
                        ),
                      ),
                    ),
                    gapW10,
                    Visibility(
                      visible: widget.booking.cancelationDate == null &&
                          widget.booking.status == BookingStatus.ongoing,
                      child: Flexible(
                        child: RoundedButton(
                          title: "Completed",
                          onPressed: () {},
                          height: 45,
                          textSize: 14,
                          buttonColor: Color(BookingStatus.completed.colorCode),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
