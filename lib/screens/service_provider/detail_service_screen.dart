import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants/asstes.dart';
import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/widgets/image_collection_widget.dart';

class DetailServiceScreen extends StatefulWidget {
  const DetailServiceScreen({
    super.key,
    this.isEditable = false,
  });
  final bool isEditable;

  @override
  State<DetailServiceScreen> createState() => _DetailServiceScreenState();
}

class _DetailServiceScreenState extends State<DetailServiceScreen> {
  late bool _isEdiatble;
  @override
  void initState() {
    super.initState();
    _isEdiatble = widget.isEditable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: CustomAppBar(
          title: _isEdiatble ? "Edit" : "Detail",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: <Widget>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.45,
                      child: ImageCollectionWidget(
                        title: _isEdiatble
                            ? AppStrings.addImages
                            : "Service Images",
                        height: screenHeight * 0.35,
                        images: const [
                          Assets.demoCar,
                          Assets.demoCar,
                          Assets.demoCar,
                        ],
                        isShowUploadButton: _isEdiatble,
                        onClickUploadImage: (index) {
                          debugPrint("Upload Card Pressed $index");
                        },
                        onClickDeleteButton: _isEdiatble
                            ? (index) {
                                debugPrint("Delete Item at $index");
                              }
                            : null,
                        onClickCard: (index) {
                          debugPrint("Pressed Image at $index");
                        },
                      ),
                    ),
                    gapH10,
                    CustomTitleTextField(
                      fieldText: AppStrings.carName,
                      hintText: AppStrings.carName,
                      isShowEdiatbleButton: _isEdiatble,
                      isReadyOnly: true,
                    ),
                    gapH24,
                    CustomTitleTextField(
                      fieldText: AppStrings.carDescription,
                      hintText: AppStrings.enterHere,
                      maxLines: 4,
                      isShowEdiatbleButton: _isEdiatble,
                      isReadyOnly: true,
                    ),
                    gapH24,
                    CustomTitleTextField(
                      fieldText: AppStrings.addModel,
                      hintText: AppStrings.enterModel,
                      isShowEdiatbleButton: _isEdiatble,
                      isReadyOnly: true,
                    ),
                    gapH24,
                    CustomTitleTextField(
                      fieldText: AppStrings.year,
                      hintText: AppStrings.enterYear,
                      keyboardType: TextInputType.number,
                      isShowEdiatbleButton: _isEdiatble,
                      isReadyOnly: true,
                    ),
                    gapH24,
                    CustomTitleTextField(
                      fieldText: "Price",
                      hintText: AppStrings.enterPriceHour,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      isShowEdiatbleButton: _isEdiatble,
                      isReadyOnly: true,
                    ),
                    const Spacer(),
                    gapH50,
                    RoundedButton(
                      title: _isEdiatble ? "Save" : "Edit",
                      onPressed: () {
                        if (!widget.isEditable) {
                          setState(
                            () {
                              _isEdiatble = true;
                            },
                          );
                        }
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
