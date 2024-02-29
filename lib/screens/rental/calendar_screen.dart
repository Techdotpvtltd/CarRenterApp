// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_bloc.dart';
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/str_ext.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  const CalendarScreen({super.key, required this.product});
  final ProductModel product;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  String? pickTime;
  String? returnTime;
  bool isButtonLoad = false;
  String? buttonLoadingText;

  List<String> _getAvailablePickTimes() {
    return timeList;
  }

  List<String> _getAvailableReturnTimes() {
    return timeList
        .where((value) => value.timeGreaterThen(to: pickTime!))
        .toList();
  }

  void _triggerBookingEvent(BookingBloc bloc) {
    if (pickTime == null) {
      CustomDilaogs().errorBox(message: "Please select Pick time.");
      return;
    }
    if (returnTime == null) {
      CustomDilaogs().errorBox(message: "Please select return time.");
      return;
    }
    bloc.add(
      BookingEventCreateBooking(
          selectedDate: selectedDate,
          bookingTime: [pickTime!, returnTime!],
          product: widget.product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        // For Requesting
        if (state is BookingStateBookingCreating ||
            state is BookingStateBookingFailure ||
            state is BookingStateBooked) {
          setState(() {
            isButtonLoad = state.isLoading;
            buttonLoadingText = state.isLoading ? "Requesting..." : null;
          });

          if (state is BookingStateBookingFailure) {
            CustomDilaogs()
                .successBox(message: "Oops! unable to book the service.");
            debugPrint(state.exception.message);
          }

          if (state is BookingStateBooked) {
            CustomDilaogs().successBox(
              message:
                  "Your Booking Request send successfully after accepted the request\nYou will receive notification.",
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
          child: Column(
            children: [
              // =========================== Table Calendar Widget ================================
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: TableCalendar(
                  focusedDay: selectedDate,
                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),
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
                    titleTextStyle:
                        StyleGuide.productCardStyle1.copyWith(fontSize: 16),
                  ),
                  calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: StyleGuide.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      pickTime = null;
                      returnTime = null;
                    });
                  },
                ),
              ),
              gapH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Pick up Time Widget
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pick-up time",
                        style:
                            StyleGuide.productCardStyle1.copyWith(fontSize: 12),
                      ),
                      gapH10,
                      DropdownButton2(
                        items: _getAvailablePickTimes()
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            pickTime = value;
                            returnTime = null;
                          });
                        },
                        underline: const SizedBox(),
                        value: pickTime,
                        hint: const Text("Select Time"),
                        customButton: Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 12, bottom: 12, right: 5),
                          decoration: const BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Row(
                            children: [
                              Text(pickTime ?? "Select Time"),
                              gapW30,
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Return Time Widget
                  if (pickTime != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Return time",
                          style: StyleGuide.productCardStyle1
                              .copyWith(fontSize: 12),
                        ),
                        gapH10,
                        DropdownButton2(
                          items: _getAvailableReturnTimes()
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              returnTime = value;
                            });
                          },
                          underline: const SizedBox(),
                          value: returnTime,
                          hint: const Text("Select Time"),
                          customButton: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 12, bottom: 12, right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Row(
                              children: [
                                Text(returnTime ?? "Selct Time"),
                                gapW30,
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              const Spacer(),
              Visibility(
                visible: pickTime != null && returnTime != null,
                child: RoundedButton(
                  isLoading: isButtonLoad,
                  loadingText: buttonLoadingText,
                  title: "Request Book",
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
