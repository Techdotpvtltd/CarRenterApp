import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/dialogs/loaders.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/widgets/map_with_text_filed.dart';
import '../../utilities/widgets/onboarding_text_widget.dart';
import '../../utilities/widgets/term_condition_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscureTextForPassword = true;
  bool _isObscureTextForConfirmPassword = true;
  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  UserLocation? _userLocation;
  String? errorMessage;
  int? errorCode;

  void _onSignupPressed() {
    context.read<AuthBloc>().add(
          AuthEventRegistering(
            firstName: _fnController.text,
            lastName: _lnController.text,
            email: _emailController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPassController.text,
            location: _userLocation,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) {
        state.isLoading
            ? Loader().show(withText: state.loadingText)
            : Loader().hide();
        if (state is AuthStateRegistering) {
          if (state.exception != null) {
            if (state.exception?.errorCode != null) {
              setState(() {
                errorMessage = state.exception!.message;
                errorCode = state.exception!.errorCode;
              });
            } else {
              CustomDilaogs().errorBox(message: state.exception?.message ?? "");
            }
          }
        }
      }),
      child: BackgroundWidget(
        topWidget: const Padding(
          padding: EdgeInsets.fromLTRB(33, 25, 33, 45),
          child: OnboardingTextWidget(
            title: AppStrings.createAccount,
            subTitle: AppStrings.pleaseFillUpYourInfo,
          ),
        ),
        bottomWidget: CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 33, right: 33, bottom: 30),
                child: Column(
                  children: [
                    CustomTitleTextField(
                      fieldText: AppStrings.firstName,
                      hintText: AppStrings.firstName,
                      controller: _fnController,
                      errorText: errorMessage,
                      filedId: 3,
                      errorCode: errorCode,
                    ),
                    gapH22,
                    CustomTitleTextField(
                      fieldText: "Last Name",
                      hintText: "Last Name",
                      controller: _lnController,
                      errorText: errorMessage,
                      filedId: 4,
                      errorCode: errorCode,
                    ),
                    gapH22,
                    CustomTitleTextField(
                      hintText: AppStrings.enterYourEmail,
                      fieldText: AppStrings.emailAddress,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      errorText: errorMessage,
                      filedId: 1,
                      errorCode: errorCode,
                    ),
                    gapH22,
                    CustomTitleTextField(
                      controller: _passwordController,
                      fieldText: AppStrings.password,
                      hintText: AppStrings.enterYourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureTextForPassword,
                      errorText: errorMessage,
                      filedId: 2,
                      errorCode: errorCode,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscureTextForPassword =
                                !_isObscureTextForPassword;
                          });
                        },
                        icon: SvgPicture.asset(
                          Assets.crossEye,
                        ),
                      ),
                    ),
                    gapH22,
                    CustomTitleTextField(
                      controller: _confirmPassController,
                      fieldText: AppStrings.confirmPassword,
                      hintText: AppStrings.enterYourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureTextForConfirmPassword,
                      errorText: errorMessage,
                      filedId: 5,
                      errorCode: errorCode,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscureTextForConfirmPassword =
                                !_isObscureTextForConfirmPassword;
                          });
                        },
                        icon: SvgPicture.asset(
                          Assets.crossEye,
                        ),
                      ),
                    ),
                    gapH22,
                    MapWithTextField(
                      controller: _locationController,
                      hintText: AppStrings.addLocation,
                      fieldText: AppStrings.addLocation,
                      errorText: errorMessage,
                      filedId: 6,
                      errorCode: errorCode,
                      mapHeight: 176,
                      onLocationFetched: (location) {
                        setState(() {
                          _userLocation = location;
                        });
                      },
                    ),
                    gapH26,
                    RoundedButton(
                        title: AppStrings.signUp,
                        onPressed: () {
                          setState(() {
                            errorMessage = null;
                            errorCode = null;
                          });
                          _onSignupPressed();
                        }),
                    gapH26,
                    Text.rich(
                      TextSpan(text: AppStrings.alreadyHaveAccount, children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.read<AuthBloc>().add(
                                    AuthEventLoadedLogin(),
                                  );
                            },
                          text: AppStrings.siginIn,
                          style: StyleGuide.onboardingText1.copyWith(
                            color: StyleGuide.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        )
                      ]),
                      style: StyleGuide.onboardingText1.copyWith(
                        color: const Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    gapH30,
                    const TermConditionWidget(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
