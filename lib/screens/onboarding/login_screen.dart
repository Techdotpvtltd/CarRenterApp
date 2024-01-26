// ignore_for_file: use_build_context_synchronously

import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/extensions/shared_preferences.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/dialogs/loaders.dart';
import 'package:beasy/utilities/widgets/onboarding_text_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/utilities/widgets/social_icon_button.dart';
import 'package:beasy/utilities/widgets/term_condition_widget.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:beasy/screens/onboarding/enable_notification_screen.dart';
import 'package:beasy/screens/onboarding/forgot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  bool _isRememberMeChecked = false;
  String? _errorMessage;
  int? _errorCode;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginUser() {
    context.read<AuthBloc>().add(AuthEventPerformLogin(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        state.isLoading
            ? Loader()
                .show(withText: state.loadingText, barrierDismissible: true)
            : Loader().hide();

        if (state is AuthStateLogging) {
          if (state.exception != null) {
            if (state.exception?.errorCode != null) {
              setState(() {
                _errorCode = state.exception?.errorCode;
                _errorMessage = state.exception?.message;
              });
            } else {
              CustomDilaogs().errorBox(message: state.exception?.message);
            }
          }
        }

        if (state is AuthStateLoggedIn) {
          // Check for permissions
          if (!await Permission.notification.isGranted &&
              await LocalPreferences.getLaterNotificationPermission() ==
                  false) {
            await NavigationService.go(
                context, const EnableNotificationScreen());
          }
        }
      },
      child: BackgroundWidget(
        topWidget: const Padding(
          padding: EdgeInsets.fromLTRB(33, 25, 33, 45),
          child: OnboardingTextWidget(
            title: AppStrings.hiWelcomBack,
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
                    top: 40, left: 33, right: 33, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTitleTextField(
                      controller: _emailController,
                      hintText: AppStrings.enterYourEmail,
                      fieldText: AppStrings.emailAddress,
                      errorCode: _errorCode,
                      errorText: _errorMessage,
                      filedId: 1,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    gapH22,
                    CustomTitleTextField(
                      controller: _passwordController,
                      fieldText: AppStrings.password,
                      hintText: AppStrings.enterYourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureText,
                      errorCode: _errorCode,
                      errorText: _errorMessage,
                      filedId: 2,
                      suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscureText = !_isObscureText;
                          });
                        },
                        icon: SvgPicture.asset(
                          Assets.crossEye,
                        ),
                      ),
                    ),
                    gapH22,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Checkbox(
                                value: _isRememberMeChecked,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                shape: const CircleBorder(),
                                side: const BorderSide(
                                  color: StyleGuide.primaryColor,
                                  width: 2,
                                ),
                                fillColor: MaterialStatePropertyAll(
                                    _isRememberMeChecked
                                        ? StyleGuide.primaryColor
                                        : Colors.transparent),
                                onChanged: (isChecked) {
                                  setState(() {
                                    _isRememberMeChecked = isChecked ?? false;
                                  });
                                },
                              ),
                            ),
                            gapW10,
                            Text(
                              AppStrings.rememberMe,
                              style: StyleGuide.onboardingText1.copyWith(
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationService.go(context, const ForgotScreen());
                          },
                          child: const TextButtonChildWidget(
                            text: AppStrings.forgotPassword,
                          ),
                        )
                      ],
                    ),
                    gapH50,
                    RoundedButton(
                      title: AppStrings.siginIn,
                      onPressed: () {
                        _loginUser();
                      },
                    ),
                    gapH20,
                    InkWell(
                      onTap: () {
                        context.read<AuthBloc>().add(AuthEventLoadedSignup());
                      },
                      child: Text(
                        AppStrings.createNewAccount,
                        style: StyleGuide.onboardingText1.copyWith(
                          color: const Color(0xFF808080),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    gapH38,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.17,
                          color: const Color(0xFF9CA4AB),
                        ),
                        gapW26,
                        Text(
                          AppStrings.orSignInWith,
                          style: StyleGuide.onboardingText1
                              .copyWith(color: const Color(0xFF9CA4AB)),
                        ),
                        gapW26,
                        Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * 0.170,
                          color: const Color(0xFF9CA4AB),
                        ),
                      ],
                    ),
                    gapH30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIconButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(AuthEventGoogleLogin());
                          },
                          icon: Assets.googleIcon,
                        ),
                        Visibility(
                          visible: Platform.isIOS,
                          child: Row(
                            children: [
                              gapW24,
                              SocialIconButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthEventAppleLogin());
                                },
                                icon: Assets.appleIcon,
                              ),
                            ],
                          ),
                        ),
                      ],
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