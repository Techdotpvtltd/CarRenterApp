import 'package:beasy/bloc/rental/rental_event.dart';
import 'package:beasy/bloc/rental/rental_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  RentalBloc() : super(RentalStateUnInitialize(isLoading: false)) {
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
