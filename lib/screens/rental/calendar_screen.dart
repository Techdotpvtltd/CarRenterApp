// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_bloc.dart';
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/models/booking_model.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/screens/service_provider/components/loading_widget.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/date_extension.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/constants/strings.dart';
import '../../utilities/widgets/custom_app_bar.dart';

/// Project: 	   CarRenterApp
/// File:    	   calendar_screem
/// Path:    	   lib/screens/rental/calendar_screen.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 11:43:11 -- Thursday
/// Description:

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, required this.product, this.booking});
  final ProductModel product;
  final BookingModel? booking;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  bool isButtonLoad = false;
  String? loadingText;
  bool isBookingAvailableAtDate = false;
  bool isFetchingBookings = true;
  List<BookingModel> bookings = [];
  late final BookingModel? existedBooking = widget.booking;

  @override
  void initState() {
    super.initState();
    triggerFetchBookingsEvent(context.read<BookingBloc>());
  }

  void freeExistedBookingTimes() {
    setState(() {
      selectedDate = existedBooking?.bookingDate ?? DateTime.now();
      bookings.removeWhere((element) => element.id == existedBooking?.id);
    });
  }

  void updateSelectedDate(DateTime withSelectedDate) {
    setState(() {
      selectedDate = withSelectedDate;
      checkServiceAvailableAtDate();
    });
  }

  void checkServiceAvailableAtDate() {
    isBookingAvailableAtDate = bookings
        .where((element) => isSameDay(element.bookingDate, selectedDate))
        .isEmpty;
  }

  void triggerFetchBookingsEvent(BookingBloc bloc) {
    bloc.add(
        BookingEventFetchForIndividualService(serviceId: widget.product.id));
  }

  void _triggerBookingEvent(BookingBloc bloc) {
    selectedDate = selectedDate.onlyDate();
    existedBooking != null
        ? bloc.add(
            BookingEventUpdateBooking(
              selectedDate: selectedDate,
              bookingModel: existedBooking!,
            ),
          )
        : bloc.add(
            BookingEventCreateBooking(
              selectedDate: selectedDate,
              product: widget.product,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        // For Fetching Booking states
        if (state is BookingStateFetchBookingSuccess ||
            state is BookingStateFetchBookingsFailure ||
            state is BookingStateFetchingBookings) {
          setState(() {
            isFetchingBookings = state.isLoading;
            loadingText = state.loadingText;

            if (state is BookingStateFetchBookingSuccess) {
              bookings = state.bookings;
              if (existedBooking != null) {
                freeExistedBookingTimes();
              }
              checkServiceAvailableAtDate();
            }
          });
        }
        // For Requesting
        if (state is BookingStateBookingCreating ||
            state is BookingStateBookingFailure ||
            state is BookingStateBooked ||
            state is BookingStateUpdateBookingFailure ||
            state is BookingStateBookingUpdating ||
            state is BookingStateBookingUpdated) {
          setState(() {
            isButtonLoad = state.isLoading;
            loadingText = state.isLoading
                ? existedBooking != null
                    ? "Updating..."
                    : "Requesting..."
                : null;
          });

          if (state is BookingStateBookingFailure ||
              state is BookingStateUpdateBookingFailure) {
            CustomDilaogs()
                .successBox(message: "Oops! unable to book the service.");
          }

          if (state is BookingStateBookingUpdated) {
            CustomDilaogs().successBox(
              message: "Booking time updated successfully.",
              title: "Booking Update",
              positiveTitle: "Go to Back",
              onPositivePressed: () {
                Navigator.pop(context);
              },
            );
          }
          if (state is BookingStateBooked) {
            CustomDilaogs().successBox(
              message:
                  "Your Booking Request sent successfully after accepted the request\nYou will receive notification.",
              title: "Booking Request",
              positiveTitle: "Go to Home",
              onPositivePressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            );
          }
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: CustomAppBar(
            title: AppStrings.dateAndTime,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: isFetchingBookings
              ? LoadingWidget(loadingText: loadingText)
              : Column(
                  children: [
                    // =========================== Table Calendar Widget ================================
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFD9D9D9),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: TableCalendar(
                        focusedDay: selectedDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(selectedDate, day),
                        holidayPredicate: (day) {
                          for (BookingModel booking in bookings) {
                            if (isSameDay(booking.bookingDate, day)) {
                              return true;
                            }
                          }
                          return false;
                        },
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 60)),
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          leftChevronIcon: const Icon(
                            Icons.chevron_left,
                            color: Colors.black,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right,
                            color: Colors.black,
                          ),
                          titleCentered: true,
                          titleTextStyle: StyleGuide.productCardStyle1
                              .copyWith(fontSize: 16),
                        ),
                        calendarStyle: const CalendarStyle(
                          holidayDecoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          holidayTextStyle: TextStyle(color: Colors.white),
                          selectedDecoration: BoxDecoration(
                            color: StyleGuide.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          updateSelectedDate(selectedDay);
                        },
                      ),
                    ),
                    gapH20,
                    const Spacer(),
                    Visibility(
                      visible: isBookingAvailableAtDate,
                      child: RoundedButton(
                        isLoading: isButtonLoad,
                        loadingText: loadingText,
                        title: existedBooking != null
                            ? "Update Booking"
                            : "Request Book",
                        onPressed: () =>
                            _triggerBookingEvent(context.read<BookingBloc>()),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
