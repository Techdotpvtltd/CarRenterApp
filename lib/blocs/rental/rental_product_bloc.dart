import 'dart:async';

import 'package:beasy/blocs/rental/rental_product_event.dart';
import 'package:beasy/blocs/rental/rental_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../exceptions/app_exceptions.dart';
import '../../models/product_model.dart';
import '../../repositories/repos/immutable_product_repo.dart';
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

    // ===========================Fetch Products Event================================
    on<RentalEventFetchProducts>(
      (event, emit) async {
        try {
          emit(RentalStateFetchingProducts());
          await ImmutableProductRepo().fetchProducts();
          final List<ProductModel> products = ImmutableProductRepo().products;
          emit(RentalStateProductsFetched(products: products));
        } on AppException catch (e) {
          debugPrint(e.message);
          emit(RentalStateFetchProductsFailure(exception: e));
        }
      },
    );
  }
}
