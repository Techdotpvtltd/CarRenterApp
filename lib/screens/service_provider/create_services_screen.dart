import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/screens/service_provider/add_information_screen.dart';
import 'package:flutter/material.dart';

import '../../utilities/widgets/image_collection_widget.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final List<String> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.createService,
          actions: [
            Text.rich(
              TextSpan(
                text: "1",
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.45,
                      child: ImageCollectionWidget(
                        title: AppStrings.addImages,
                        height: screenHeight * 0.35,
                        images: images,
                        onClickUploadImage: (file) {
                          setState(() {
                            images.add(file.path);
                          });
                        },
                        onClickDeleteButton: (index) {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                        onClickCard: (index) {
                          debugPrint("Pressed Image at $index");
                        },
                      ),
                    ),
                    gapH20,
                    const CustomTitleTextField(
                      fieldText: AppStrings.carName,
                      hintText: AppStrings.enterName,
                    ),
                    gapH20,
                    const CustomTitleTextField(
                      fieldText: AppStrings.carDescription,
                      hintText: AppStrings.enterHere,
                      maxLines: 6,
                    ),
                    const Spacer(),
                    gapH50,
                    RoundedButton(
                      title: AppStrings.next,
                      onPressed: () {
                        NavigationService.go(
                            context, const AddInformationScreen());
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
