import 'package:beasy/app_manager/app_manager.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialize()) {
    // on Initialize  ========================================
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateStartup(isLoading: false));
    });

    // Show Login Screen Event  ========================================
    on<AuthEventLoadedLogin>((event, emit) => emit(AuthStateLoadedLogin()));
    // Show GetStarted Screen Event  ========================================
    on<AuthEventLoadedGetStarted>(
        (event, emit) => emit(AuthStateLoadedGetStarted()));
    // Show SignUp Screen  ========================================
    on<AuthEventLoadedSignup>(
      (event, emit) => emit(AuthStateLoadedSignup()),
    );

    // Show UserType Screen  ========================================
    on<AuthEventNeedsToSetUserType>(
      (event, emit) => emit(AuthStateNeedsToSetUserType()),
    );

    on<AuthEventUserTypeSet>((event, emit) {
      AppManager().setUser = UserModel(
          userType: event.selectedIndex == 0
              ? UserType.rentalUser
              : UserType.serviceProvider);
      emit(AuthStateUserTypeSet(isLoading: false));
      emit(AuthStateRegistered());
    });
    // Show Noticiation Enabled Screen  ========================================
    on<AuthEventNeedsToEnableNotification>(
      (event, emit) => emit(AuthStateNeedsToEnableNotification()),
    );

    // Show Access Location Screen  ============================================
    on<AuthEventNeedsToAllowLocationAccess>(
      (event, emit) => emit(AuthStateNeedToAllowLocation()),
    );

    // Show Next Screens  ============================================
    on<AuthEventRegistered>(
      (event, emit) => emit(AuthStateRegistered()),
    );
  }
}
