import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';
import 'package:beasy/repositories/exceptions/data_exceptions.dart';
import 'package:beasy/repositories/repos/aut_repo.dart';
import 'package:flutter/material.dart';
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
    on<AuthEventUserTypeSet>((event, emit) async {
      emit(AuthStateSettingUserType(
          isLoading: true, loadingText: "Setting user role..."));
      try {
        await AuthRepo().setUserType(index: event.selectedIndex);
        emit(AuthStateSetUserType(isLoading: false));
      } on BeasyException catch (e) {
        emit(AuthStateSettingUserType(isLoading: false, exception: e));
      } on Exception catch (e) {
        debugPrint(e.toString());
        emit(AuthStateSettingUserType(
            isLoading: false, exception: DataExceptionUnknown()));
      }
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
    on<AuthEventRegistering>(
      (event, emit) async {
        emit(AuthStateRegistering(
            isLoading: true, loadingText: "Creating user."));

        try {
          await AuthRepo().registeredUser(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            password: event.password,
            confirmPassword: event.confirmPassword,
            location: event.location,
          );
          emit(AuthStateNeedsToSetUserType(
              isLoading: false, isComingFromSignup: true));
          return;
        } on BeasyException catch (e) {
          emit(AuthStateRegistering(isLoading: false, exception: e));
        } on Exception catch (e) {
          debugPrint(e.toString());
          emit(AuthStateRegistering(
              isLoading: false, exception: DataExceptionUnknown()));
        }
      },
    );
  }
}
