import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialize(isLoading: false)) {
    // on Initialize  ========================================
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateStartup(isLoading: false));
    });
  }
}
