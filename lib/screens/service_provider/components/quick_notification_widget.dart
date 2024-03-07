// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/booking/booking_bloc.dart';
import 'package:beasy/blocs/booking/booking_event.dart';
import 'package:beasy/blocs/booking/booking_state.dart';
import 'package:beasy/blocs/notification/notification_bloc.dart';
import 'package:beasy/blocs/notification/notification_event.dart';
import 'package:beasy/blocs/notification/notification_state.dart';
import 'package:beasy/repositories/repos/notification_repo.dart';
import 'package:beasy/screens/service_provider/components/error_widget.dart';
import 'package:beasy/screens/service_provider/components/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/booking_model.dart';
import '../../../utilities/widgets/notification_card.dart';

/// Project: 	   CarRenterApp
/// File:    	   quick_notification_widget
/// Path:    	   lib/screens/service_provider/components/quick_notification_widget.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 17:17:26 -- Thursday
/// Description:

class QuickNotificationWidget extends StatefulWidget {
  const QuickNotificationWidget({super.key, this.isComingFromHome = false});
  final bool isComingFromHome;
  @override
  State<QuickNotificationWidget> createState() =>
      _QuickNotificationWidgetState();
}

class _QuickNotificationWidgetState extends State<QuickNotificationWidget> {
  bool isLoading = false;
  String loadingText = "";
  bool isError = false;
  List<BookingModel> bookings = NotificationRepo().bookings;

  @override
  void initState() {
    super.initState();
    _fetchAllBookings();
  }

  void _fetchAllBookings() {
    setState(() {
      isError = false;
    });
    context.read<NotificationBloc>().add(NotificationEventFetch());
  }

  Widget _getCurrentWidget() {
    if (isLoading) {
      return const LoadingWidget();
    }

    if (isError) {
      return CustomAlertWidget(
        message: "Oops! Something went wrong",
        onPressedRefresh: () => _fetchAllBookings(),
      );
    }

    return bookings.isEmpty
        ? CustomAlertWidget(
            message: "No pending bookings.",
            onPressedRefresh: () => _fetchAllBookings(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              _fetchAllBookings();
            },
            child: _NotificationListWidget(bookings),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationStateFetching ||
            state is NotificationStateFetchFailure ||
            state is NotificationStateFetched) {
          setState(() {
            isError = false;
            isLoading = state.isLoading;
            loadingText = state.loadingText;
            if (state is NotificationStateFetchFailure) {
              isError = true;
            }

            if (state is NotificationStateFetched) {
              setState(() {
                isError = false;
                bookings = NotificationRepo().bookings;
                if (widget.isComingFromHome && bookings.length > 5) {
                  bookings = bookings
                      .where((element) =>
                          element.status == BookingStatus.pending &&
                          element.bookingDate.microsecondsSinceEpoch.compareTo(
                                  DateTime.now().microsecondsSinceEpoch) ==
                              1)
                      .take(5)
                      .toList();
                }
              });
            }
          });
        }
      },
      child: _getCurrentWidget(),
    );
  }
}

class _NotificationListWidget extends StatefulWidget {
  const _NotificationListWidget(this.bookings);
  final List<BookingModel> bookings;

  @override
  State<_NotificationListWidget> createState() =>
      _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<_NotificationListWidget> {
  int? updatedIndex;
  bool isButtonLoading = false;
  BookingStatus? status;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.bookings.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: BlocListener<BookingBloc, BookingState>(
            listener: (context, state) {
              if (state is BookingStateUpdateStatusFailure ||
                  state is BookingStateStatusUpdated ||
                  state is BookingStateUpdatingStatus) {
                setState(() {
                  isButtonLoading = state.isLoading;

                  if (state is BookingStateStatusUpdated) {
                    status = state.status;
                    final currentIndex = widget.bookings
                        .indexWhere((element) => element.id == state.id);
                    if (currentIndex > 0) {
                      widget.bookings[currentIndex] = widget
                          .bookings[currentIndex]
                          .copyWith(status: state.status);
                    }
                  }
                });
              }
            },
            child: NotificationCard(
              booking: widget.bookings[index],
              onButtonPressed: (status) {
                setState(() {
                  updatedIndex = index;
                });
                context.read<BookingBloc>().add(BookingEventUpdateStatus(
                    bookingId: widget.bookings[index].id, status: status));
              },
              isLoadingButton: updatedIndex == index && isButtonLoading,
            ),
          ),
        );
      },
    );
  }
}
