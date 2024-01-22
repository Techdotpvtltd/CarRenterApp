abstract class SPState {
  final bool isLoading;
  final String loadingText;

  SPState({required this.isLoading, this.loadingText = ""});
}

class SPStateInitialize extends SPState {
  SPStateInitialize({super.isLoading = false});
}

class SPStateUninitialize extends SPState {
  SPStateUninitialize({super.isLoading = false});
}
