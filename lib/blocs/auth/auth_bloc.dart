import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/main.dart';
import 'package:beasy/repositories/exceptions/beasy_exceptions.dart';
import 'package:beasy/repositories/exceptions/data_exceptions.dart';
import 'package:beasy/repositories/repos/auth_repo.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/views/common/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateUninitialize()) {
    // on Initialize  ========================================
    on<AuthEventInitialize>((event, emit) {
      emit(AuthStateStartup(isLoading: false));
    });

    //  Login Screen Event  ========================================
    on<AuthEventLoadedLogin>((event, emit) => emit(AuthStateLoadedLogin()));

    // Display User Type Screen
    on<AuthEventNeedsToSetUserType>(
      (event, emit) => emit(AuthStateNeedsToSetUserType()),
    );
    // On Logout Request  ============================================
    on<AuthEventPerformLogout>(
      (event, emit) async {
        await AuthRepo().performLogout();
        emit(AuthStateInitialize());
      },
    );
    // Splash Process completed  ============================================
    on<AuthEventSplashActionDone>(
        (event, emit) => emit(AuthStateSplashActionDone()));

    on<AuthEventPerformLogin>((event, emit) async {
      emit(AuthStateLogging(
        isLoading: true,
        loadingText: "Login...",
      ));

      try {
        await AuthRepo()
            .loginUser(withEmail: event.email, withPassword: event.password);
        emit(AuthStateLoggedIn(isLoading: false));
      } on BeasyException catch (e) {
        if (e is DataExceptionNotFound) {
          emit(AuthStateLoggedIn(isLoading: false));
          await NavigationService.go(
            navKey.currentContext!,
            const ProfileScreen(
              isEditingEnabled: true,
              isShowBack: false,
              isCommingFromLogin: true,
            ),
          );
          return;
        }

        emit(AuthStateLogging(
          isLoading: false,
          exception: e,
        ));
      } on FirebaseException catch (e) {
        emit(AuthStateLogging(
          isLoading: false,
          exception: DataExceptionUnknown(message: e.toString()),
        ));
      }
    });

    // Show GetStarted Screen Event  ========================================
    on<AuthEventLoadedGetStarted>(
        (event, emit) => emit(AuthStateLoadedGetStarted()));
    // Show SignUp Screen  ========================================
    on<AuthEventLoadedSignup>(
      (event, emit) => emit(AuthStateLoadedSignup()),
    );

    // // Show UserType Screen  ========================================
    // on<AuthEventUserTypeSet>((event, emit) async {
    //   emit(AuthStateSettingUserType(
    //       isLoading: true, loadingText: "Setting user role..."));
    //   try {
    //     await AuthRepo().setUserType(index: event.selectedIndex);
    //     emit(AuthStateSetUserType(isLoading: false));
    //   } on BeasyException catch (e) {
    //     emit(AuthStateSettingUserType(isLoading: false, exception: e));
    //   } on Exception catch (e) {
    //     debugPrint(e.toString());
    //     emit(AuthStateSettingUserType(
    //         isLoading: false,
    //         exception: DataExceptionUnknown(message: e.toString())));
    //   }
    // });
    // Show Noticiation Enabled Screen  ========================================
    on<AuthEventNeedsToEnableNotification>(
      (event, emit) => emit(AuthStateNeedsToEnableNotification()),
    );

    // Show Access Location Screen  ============================================
    on<AuthEventNeedsToAllowLocationAccess>(
      (event, emit) => emit(AuthStateNeedToAllowLocation()),
    );

    /// Updating User Profile
    on<AuthEventUpdateUserProfile>(
      (event, emit) async {
        emit(AuthStateUpdatingUserProfile(
          isLoading: true,
          loadingText: "Updating..",
        ));

        try {
          await UserRepo().update(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            userLocation: event.location,
            phoneNumber: event.phoneNumber,
            imagePath: event.imagePath,
          );
          emit(AuthStateUpdatedUserProfile(isLoading: false));
        } on BeasyException catch (e) {
          emit(AuthStateUpdatingUserProfile(
            isLoading: false,
            exception: e,
          ));
        } on Exception catch (e) {
          emit(AuthStateUpdatingUserProfile(
            isLoading: false,
            exception: DataExceptionUnknown(message: e.toString()),
          ));
        }
      },
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
          return;
        } on BeasyException catch (e) {
          emit(AuthStateRegistering(isLoading: false, exception: e));
        } on Exception catch (e) {
          debugPrint(e.toString());
          emit(AuthStateRegistering(
              isLoading: false,
              exception: DataExceptionUnknown(message: e.toString())));
        }
      },
    );
  }
}
