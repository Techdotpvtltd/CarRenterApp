import 'package:beasy/blocs/data_fetcher/data_fetcher_cubit.dart';
import 'package:beasy/blocs/data_fetcher/data_fetcher_state.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/helping_methods.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../screens/service_provider/booking_detail_view_sp.dart';
import '../constants/asstes.dart';
import '../constants/constants.dart';
import '../constants/style_guide.dart';
import '../extensions/navigation_service.dart';
import 'rounded_button.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({super.key, required this.booking});
  final BookingModel booking;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    DataFetcherCubit().scheduleTime();
  }

  @override
  Widget build(BuildContext context) {
    final bool isRentalUser =
        UserRepo().currentUser.userType == UserType.rentalUser;
    final ProductModel? product = ImmutableProductRepo()
        .products
        .where((e) => e.id == widget.booking.serviceId)
        .firstOrNull;
    return InkWell(
      onTap: () {
        NavigationService.go(context,
            BookingDetailViewSP(booking: widget.booking, userModel: user));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffF3F4F9),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<UserModel?>(
                  future: UserRepo()
                      .fetchUser(profileId: widget.booking.rentalUserId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      user = snapshot.data;
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: CustomNetworkImage(
                            imageUrl: user?.imageUrl ?? "",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        gapW8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.firstName ?? "---",
                                style: const TextStyle(
                                  fontFamily: Assets.plusJakartaFont,
                                  color: StyleGuide.textColor2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              gapH4,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "I want to book your ${product?.name} car.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: Assets.plusJakartaFont,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  gapW14,
                                  Image.asset(
                                    "assets/icons/car.png",
                                    height: 23,
                                    width: 48,
                                    fit: BoxFit.fill,
                                  ),
                                  gapW10,

                                  /// Remaining Time Widgets
                                  BlocSelector<DataFetcherCubit, dynamic,
                                      DataFetcherTimePeriod?>(
                                    selector: (state) =>
                                        state is DataFetcherTimePeriod
                                            ? DataFetcherTimePeriod()
                                            : null,
                                    builder: (context, state) {
                                      return Text(
                                        parseTimePeriod(
                                            atTime: widget.booking.createdAt),
                                        style: const TextStyle(
                                            fontFamily: Assets.plusJakartaFont,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            color: StyleGuide.textColor2),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                DateFormat("dd/MM/yyyy")
                                    .format(widget.booking.bookingDate),
                                style: const TextStyle(
                                  color: StyleGuide.textColor2,
                                  fontFamily: Assets.plusJakartaFont,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              gapH4,
                              Text(
                                remainingTime(
                                    atTime: widget.booking.bookingDate),
                                style: const TextStyle(
                                    fontFamily: Assets.plusJakartaFont,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: StyleGuide.primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              gapH16,
              Center(
                child: isRentalUser
                    ? RoundedButton(
                        title: "Pay now",
                        onPressed: () {},
                        width: 162,
                        height: 32,
                        textSize: 12,
                      )
                    : Row(
                        children: [
                          /// Accepted and rejected buttons
                          Visibility(
                            visible: !isRentalUser &&
                                widget.booking.status == BookingStatus.pending,
                            child: Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RoundedButton(
                                      title: "Reject",
                                      onPressed: () {},
                                      height: 32,
                                      textSize: 12,
                                      withBorderOnly: true,
                                      buttonColor: Color(
                                          BookingStatus.rejected.colorCode),
                                    ),
                                  ),
                                  gapW4,
                                  Expanded(
                                    child: RoundedButton(
                                      title: "Accept",
                                      onPressed: () {},
                                      height: 32,
                                      textSize: 12,
                                      buttonColor: Color(
                                          BookingStatus.accepted.colorCode),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /// OnGoing and Completed Buttons
                          Visibility(
                            visible: !isRentalUser &&
                                (widget.booking.status == BookingStatus.paid ||
                                    widget.booking.status ==
                                        BookingStatus.ongoing),
                            child: Expanded(
                              child: Row(
                                children: [
                                  Visibility(
                                    visible: !isRentalUser &&
                                        widget.booking.status ==
                                            BookingStatus.paid,
                                    child: Expanded(
                                      child: RoundedButton(
                                        title: "Mark On-Going",
                                        onPressed: () {},
                                        height: 32,
                                        textSize: 12,
                                        buttonColor: Color(
                                            BookingStatus.ongoing.colorCode),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !isRentalUser &&
                                        widget.booking.status ==
                                            BookingStatus.ongoing,
                                    child: Expanded(
                                      child: RoundedButton(
                                        title: "Mark Completed",
                                        onPressed: () {},
                                        height: 32,
                                        textSize: 12,
                                        buttonColor: Color(
                                            BookingStatus.completed.colorCode),
                                      ),
                                    ),
                                  ),
                                ],
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
