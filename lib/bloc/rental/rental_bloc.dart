import 'dart:async';

import 'package:beasy/bloc/rental/rental_event.dart';
import 'package:beasy/bloc/rental/rental_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../drawer/drawer_cubit.dart';
import '../drawer/drawer_screen_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  late StreamSubscription drawerBlocSubscription;

  RentalBloc() : super(RentalStateUnInitialize(isLoading: false)) {
    drawerBlocSubscription = DrawerCubit().stream.listen((state) {
      if (state is DrawerStateToggled) {
        debugPrint("Opened = ${state.isOpened.toString()}");
      }
    });

    on<RentalEventInitialize>((event, emit) {
      emit(RentalStateInitialize(isLoading: false));
    });

    on<RentalEventIsDrawerOpened>(
      (event, emit) {
        debugPrint("RentalEventIsDrawerOpened");
      },
    );
  }
}
