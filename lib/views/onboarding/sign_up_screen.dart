import 'package:beasy/bloc/auth/auth_bloc.dart';
import 'package:beasy/bloc/auth/auth_event.dart';
import 'package:beasy/bloc/auth/auth_state.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: ((context, state) {}),
      child: BackgroundWidget(
        innerWidget: const Padding(
          padding: EdgeInsets.fromLTRB(33, 25, 33, 45),
          child: OnboardingTextWidget(
            title: AppStrings.createAccount,
            subTitle: AppStrings.pleaseFillUpYourInfo,
          ),
        ),
        outerWidget: CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 33, right: 33, bottom: 30),
                child: Column(
                  children: [
                    const CustomTitleTextField(
                        fieldText: AppStrings.firstName,
                        hintText: AppStrings.firstName),
                    gapH22,
                    const CustomTitleTextField(
                      hintText: AppStrings.enterYourEmail,
                      fieldText: AppStrings.emailAddress,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    gapH22,
                    CustomTitleTextField(
                      fieldText: AppStrings.password,
                      hintText: AppStrings.enterYourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureTextForPassword,
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
                      fieldText: AppStrings.confirmPassword,
                      hintText: AppStrings.enterYourPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isObscureTextForConfirmPassword,
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
                    const CustomTitleTextField(
                      hintText: AppStrings.addLocation,
                      fieldText: AppStrings.addLocation,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    gapH26,
                    Image.asset('assets/images/demo_map.png'),
                    gapH26,
                    RoundedButton(
                        title: AppStrings.signUp,
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthEventNeedsToSetUserType());
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
