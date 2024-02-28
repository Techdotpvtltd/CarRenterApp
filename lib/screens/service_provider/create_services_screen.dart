import 'package:beasy/models/product_model.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
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
  final TextEditingController nameTFController = TextEditingController();
  final TextEditingController descTFController = TextEditingController();
  String? errorMessage;
  int? errorCode;
  ProductModel? productModel;

  void _validateAndLoadNextScreen() {
    setState(() {
      errorCode = null;
      errorMessage = null;
    });
    if (images.isEmpty) {
      CustomDilaogs().errorBox(message: "Please upload at least one image");
      return;
    }

    if (nameTFController.text == "") {
      setState(() {
        errorCode = 1;
        errorMessage = "Please enter car name";
      });
      return;
    }
    final UserModel user = UserRepo().user;
    productModel = ProductModel(
        id: "",
        ownerId: user.uid,
        createdAt: DateTime.now(),
        images: images,
        name: nameTFController.text,
        description: descTFController.text,
        model: "",
        year: 0,
        price: 0,
        latitude: user.location.latitude,
        longitude: user.location.longitude);

    NavigationService.go(
      context,
      AddInformationScreen(
        productModel: productModel!,
      ),
    );
  }

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

                      /// Image Collection Widget
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

                    /// Car Name Field
                    gapH20,
                    CustomTitleTextField(
                      controller: nameTFController,
                      errorCode: errorCode,
                      errorText: errorMessage,
                      fieldId: 1,
                      fieldText: AppStrings.carName,
                      hintText: AppStrings.enterName,
                    ),

                    /// Car Description Field
                    gapH20,
                    CustomTitleTextField(
                      controller: descTFController,
                      errorCode: errorCode,
                      errorText: errorMessage,
                      fieldText: AppStrings.carDescription,
                      hintText: AppStrings.enterHere,
                      maxLines: 6,
                    ),
                    const Spacer(),
                    gapH50,

                    /// Next Button
                    RoundedButton(
                      title: AppStrings.next,
                      onPressed: () => _validateAndLoadNextScreen(),
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
