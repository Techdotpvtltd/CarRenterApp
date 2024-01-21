abstract class DrawerScreenState {
  final bool isLoading;

  DrawerScreenState({required this.isLoading});
}

class DrawerStateInitialize extends DrawerScreenState {
  DrawerStateInitialize({required super.isLoading});
}

class DrawerStateToggled extends DrawerScreenState {
  final bool isOpened;
  DrawerStateToggled(this.isOpened, {required super.isLoading});
}

class DrawerStateUpdated extends DrawerScreenState {
  DrawerStateUpdated({super.isLoading = false});
}
