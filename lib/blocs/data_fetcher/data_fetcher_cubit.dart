// ignore: dangling_library_doc_comments
import 'dart:async';

import 'package:beasy/blocs/data_fetcher/data_fetcher_state.dart';
import 'package:beasy/exceptions/app_exceptions.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Project: 	   CarRenterApp
/// File:    	   data_fetcher_cubit
/// Path:    	   lib/blocs/data_fetcher/data_fetcher_cubit.dart
/// Author:       Ali Akbar
/// Date:        01-03-24 17:14:06 -- Friday
/// Description:

class DataFetcherCubit extends Cubit<dynamic> {
  static final DataFetcherCubit _instance = DataFetcherCubit.internal();
  DataFetcherCubit.internal() : super(0);
  factory DataFetcherCubit() => _instance;

  Timer? timer;

  void fetchUserProfile({required String profileId}) async {
    try {
      final user = await UserRepo().fetchUser(profileId: profileId);
      emit(user);
    } on AppException catch (e) {
      debugPrint(e.message);
    }
  }

  void scheduleTime() {
    timer ??= Timer.periodic(const Duration(minutes: 1), (timer) {
      emit(DataFetcherTimePeriod());
    });
  }

  void cancelTimer() {
    if (timer != null) {
      timer?.cancel();
    }
  }
}
