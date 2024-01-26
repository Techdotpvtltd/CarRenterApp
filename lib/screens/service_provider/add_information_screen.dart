import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/strings.dart';
import '../../utilities/constants/style_guide.dart';
import '../../utilities/widgets/custom_app_bar.dart';

class AddInformationScreen extends StatelessWidget {
  const AddInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.addInformation,
          actions: [
            Text.rich(
              TextSpan(
                text: "2",
                children: [
                  TextSpan(
                    text: "/2",
                    style: StyleGuide.serviceProviderStyle1.copyWith(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              style: StyleGuide.serviceProviderStyle1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            children: [
              const CustomTitleTextField(
                fieldText: AppStrings.addModel,
                hintText: AppStrings.enterModel,
              ),
              gapH22,
              const CustomTitleTextField(
                fieldText: AppStrings.year,
                hintText: AppStrings.enterYear,
                keyboardType: TextInputType.number,
              ),
              gapH22,
              const CustomTitleTextField(
                fieldText: "Price",
                hintText: AppStrings.enterPriceHour,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const Spacer(),
              RoundedButton(title: AppStrings.upload, onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
