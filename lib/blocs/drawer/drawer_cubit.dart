import 'dart:async';

import 'package:beasy/blocs/drawer/drawer_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerCubit extends Cubit<DrawerScreenState> {
  DrawerCubit() : super(DrawerStateInitialize(isLoading: false)) {
    zoomDrawerController = ZoomDrawerController();
  }

  late ZoomDrawerController zoomDrawerController;
  int _currentIndex = -1;
  get currentIndex => _currentIndex;
  bool _open = false;
  get open => _open;

  void openDrawer() {
    Timer(const Duration(microseconds: 800), () {
      _open = true;
      emit(DrawerStateToggled(true, isLoading: false));
    });
    zoomDrawerController.toggle?.call();
    emit(DrawerStateToggled(true, isLoading: false));
  }

  void closeDrawer() {
    Timer(const Duration(microseconds: 800), () {
      _open = false;
      emit(DrawerStateToggled(false, isLoading: false));
    });
    zoomDrawerController.close?.call();
  }

  set setIndex(index) {
    _currentIndex = index;
    emit(DrawerStateUpdated());
  }

  set setOpen(isOpend) {
    _open = isOpend;
    emit(DrawerStateUpdated());
  }
}
