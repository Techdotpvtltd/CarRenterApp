import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/onboarding_text_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/utilities/widgets/social_icon_button.dart';
import 'package:beasy/utilities/widgets/term_condition_widget.dart';
import 'package:beasy/utilities/widgets/text_button_child_widget.dart';
import 'package:beasy/views/onboarding/forgot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  bool _isRememberMeChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
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
                      obscureText: _isObscureText,
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
                        context
                            .read<AuthBloc>()
                            .add(AuthEventNeedsToSetUserType());
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
                          onPressed: () {},
                          icon: Assets.googleIcon,
                        ),
                        gapW24,
                        SocialIconButton(
                          onPressed: () {},
                          icon: Assets.appleIcon,
                        ),
                        gapW24,
                        SocialIconButton(
                          onPressed: () {},
                          icon: Assets.fbIcon,
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
