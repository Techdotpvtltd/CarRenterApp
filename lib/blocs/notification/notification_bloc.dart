// ignore: dangling_library_doc_comments
import 'package:beasy/blocs/notification/notification_event.dart';
import 'package:beasy/blocs/notification/notification_state.dart';
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/notification_repo.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Project: 	   CarRenterApp
/// File:    	   notification_bloc
/// Path:    	   lib/blocs/notification/notification_bloc.dart
/// Author:       Ali Akbar
/// Date:        29-02-24 19:04:13 -- Thursday
/// Description:

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationStateInitial()) {
    // ===========================Fetch Notification Event================================
    on<NotificationEventFetch>(
      (event, emit) async {
        final UserModel user = UserRepo().currentUser;
        try {
          // Service Provider
          emit(NotificationStateFetching());
          if (user.userType == UserType.serviceProvider) {
            await NotificationRepo().fetchForServiceProvider();
          }

          emit(NotificationStateFetched());
        } on AppException catch (e) {
          debugPrint(e.message);
          emit(NotificationStateFetchFailure(exception: e));
        }
      },
    );
  }
}
