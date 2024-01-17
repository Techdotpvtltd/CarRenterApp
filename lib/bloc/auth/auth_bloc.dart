import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialize(isLoading: false)) {
    // on Initialize  ========================================
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateStartup(isLoading: false));
    });

    // Show Login Screen Event  ========================================
    on<AuthEventLoadedLogin>(
        (event, emit) => emit(AuthStateLoadedLogin(isLoading: false)));
    // Show GetStarted Screen Event  ========================================
    on<AuthEventLoadedGetStarted>(
        (event, emit) => emit(AuthStateLoadedGetStarted(isLoading: false)));
    // Show SignUp Screen  ========================================
    on<AuthEventLoadedSignup>(
      (event, emit) => emit(AuthStateLoadedSignup(isLoading: false)),
    );
    // Show UserType Screen  ========================================
    on<AuthEventNeedsToSetUserType>(
      (event, emit) => emit(AuthStateNeedsToSetUserType(isLoading: false)),
    );

    // Show Noticiation Enabled Screen  ========================================
    on<AuthEventNeedsToEnableNotification>(
      (event, emit) =>
          emit(AuthStateNeedsToEnableNotification(isLoading: false)),
    );

    // Show Access Location Screen  ============================================
    on<AuthEventNeedsToAllowLocationAccess>(
      (event, emit) => emit(AuthStateNeedToAllowLocation(isLoading: false)),
    );

    // Show Next Screens  ============================================
    on<AuthEventRegistered>(
      (event, emit) => emit(AuthStateRegistered(isLoading: false)),
    );
  }
}
