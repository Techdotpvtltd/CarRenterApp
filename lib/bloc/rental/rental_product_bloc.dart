import 'dart:async';

import 'package:beasy/bloc/rental/rental_product_event.dart';
import 'package:beasy/bloc/rental/rental_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../drawer/drawer_cubit.dart';
import '../drawer/drawer_screen_state.dart';

class RentalProductBloc extends Bloc<RentalProductEvent, RentalProductState> {
  late StreamSubscription drawerBlocSubscription;

  RentalProductBloc()
      : super(RentalProductStateUnInitialize(isLoading: false)) {
    drawerBlocSubscription = DrawerCubit().stream.listen((state) {
      if (state is DrawerStateToggled) {
        debugPrint("Opened = ${state.isOpened.toString()}");
      }
    });

    on<RentalProductEventInitialize>((event, emit) {
      emit(RentalProductStateInitialize(isLoading: false));
    });
  }
}
