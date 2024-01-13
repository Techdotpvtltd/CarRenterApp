import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialize(isLoading: false)) {
    // on Initialize  ========================================
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateStartup(isLoading: false));
    });

    // Loading Login Screen Event  ========================================
    on<AuthEventLoadedLogin>(
        (event, emit) => emit(AuthStateLoadedLogin(isLoading: false)));
    on<AuthEventLoadedGetStarted>(
        (event, emit) => emit(AuthStateLoadedGetStarted(isLoading: false)));
  }
}
