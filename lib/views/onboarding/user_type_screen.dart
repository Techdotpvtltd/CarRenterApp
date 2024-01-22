import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/auth/auth_event.dart';
import 'package:beasy/blocs/auth/auth_state.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/onboarding_text_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {},
      child: BackgroundWidget(
        topWidget: const Padding(
          padding: EdgeInsets.only(top: 0, left: 33, right: 33, bottom: 25),
          child: OnboardingTextWidget(
            title: AppStrings.areYou,
            subTitle: AppStrings.pleaseSelectYourRoleForThisApp,
          ),
        ),
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 44),
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    /// Rental Widget
                    Row(
                      children: [
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: Radio(
                            value: 0,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(
                                () {
                                  _value = value as int;
                                },
                              );
                            },
                            visualDensity: VisualDensity.compact,
                            fillColor: const MaterialStatePropertyAll(
                                StyleGuide.primaryColor),
                            splashRadius: 0,
                          ),
                        ),
                        gapW12,
                        const Text(
                          AppStrings.rental,
                          style: TextStyle(
                            color: Color(0xFF181717),
                            fontFamily: Assets.plusJakartaFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    gapH20,
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6F8FE),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        Assets.userIcon,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    gapH38,
                    const Text(
                      "-Or-",
                      style: TextStyle(
                        color: StyleGuide.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: Assets.plusJakartaFont,
                      ),
                    ),
                    gapH20,

                    /// Service Provider Widget
                    Row(
                      children: [
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value as int;
                              });
                            },
                            visualDensity: VisualDensity.compact,
                            fillColor: const MaterialStatePropertyAll(
                                StyleGuide.primaryColor),
                            splashRadius: 0,
                          ),
                        ),
                        gapW12,
                        const Text(
                          AppStrings.serviceProvider,
                          style: TextStyle(
                            color: Color(0xFF181717),
                            fontFamily: Assets.plusJakartaFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    gapH20,
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6F8FE),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        Assets.vanIcon,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    gapH24,
                    RoundedButton(
                      title: AppStrings.next,
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(AuthEventUserTypeSet(selectedIndex: _value));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
