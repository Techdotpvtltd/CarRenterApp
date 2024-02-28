import 'package:beasy/blocs/service_provider/sp_bloc.dart';
import 'package:beasy/blocs/service_provider/sp_event.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/constants.dart';
import '../../utilities/constants/strings.dart';
import '../../utilities/widgets/dialogs/dialogs.dart';
import '../../utilities/widgets/image_collection_widget.dart';

class DetailServiceScreen extends StatefulWidget {
  const DetailServiceScreen({
    super.key,
    this.isEditable = false,
    required this.product,
  });
  final ProductModel product;
  final bool isEditable;

  @override
  State<DetailServiceScreen> createState() => _DetailServiceScreenState();
}

class _DetailServiceScreenState extends State<DetailServiceScreen> {
  late bool _isEdiatble;
  late final ProductModel product;
  bool isLoading = false;
  String? loadingText;

  List<String> images = [];
  final TextEditingController nameTFController = TextEditingController();
  final TextEditingController descTFController = TextEditingController();
  final TextEditingController modelTFController = TextEditingController();
  final TextEditingController yearTFController = TextEditingController();
  final TextEditingController priceTFController = TextEditingController();

  String? errorMessage;
  int? errorCode;

  void _triggerUpdateEvent(SPBloc bloc) {
    final int year = int.tryParse(yearTFController.text) ?? 0;
    final double price = double.tryParse(priceTFController.text) ?? 0;
    final updatedProduct = product.copyWith(
        images: images,
        name: nameTFController.text,
        description: descTFController.text,
        model: modelTFController.text,
        year: year,
        price: price);
    bloc.add(SPEventUpdateProduct(product: updatedProduct));
  }

  @override
  void initState() {
    super.initState();
    _isEdiatble = widget.isEditable;
    setState(() {
      product = widget.product;
      nameTFController.text = product.name;
      descTFController.text = product.description ?? "";
      modelTFController.text = product.model;
      yearTFController.text = product.year.toString();
      priceTFController.text = product.price.toString();
      images = product.images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SPBloc, SPState>(
      listener: (context, state) {
        if (state is SPStateUpdatingProduct ||
            state is SPStateUpdateProductFailure ||
            state is SPStateUpdatedProduct ||
            state is SPStateUploadingImage ||
            state is SPStateUploadedImage) {
          setState(() {
            loadingText = state.loadingText;
            isLoading = state.isLoading;
          });

          if (state is SPStateUpdateProductFailure) {
            if (state.exception.errorCode != null) {
              setState(() {
                errorCode = state.exception.errorCode;
                errorMessage = state.exception.message;
              });
              return;
            }
            CustomDilaogs().errorBox(message: state.exception.message);
          }

          if (state is SPStateUpdatedProduct) {
            CustomDilaogs().successBox(
              message: "Congratulation!\nYour service is updated.",
              barrierDismissible: false,
              onPositivePressed: () {
                Navigator.pop(context);
              },
              positiveTitle: "Go Back",
            );
          }
        }
      },
      child: Scaffold(
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
                        height: images.length > 2 || _isEdiatble
                            ? screenHeight * 0.45
                            : (screenHeight * 0.45) / 1.8,
                        child: ImageCollectionWidget(
                          title: _isEdiatble
                              ? AppStrings.addImages
                              : "Service Images",
                          height: screenHeight * 0.35,
                          images: images,
                          isShowUploadButton: _isEdiatble,
                          onClickUploadImage: (file) {
                            setState(() {
                              images.add(file.path);
                            });
                          },
                          onClickDeleteButton: _isEdiatble
                              ? (index) {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                }
                              : null,
                          onClickCard: (index) {
                            debugPrint("Pressed Image at $index");
                          },
                        ),
                      ),
                      gapH10,
                      CustomTitleTextField(
                        controller: nameTFController,
                        errorCode: errorCode,
                        errorText: errorMessage,
                        fieldId: 11,
                        fieldText: AppStrings.carName,
                        hintText: AppStrings.carName,
                        isShowEdiatbleButton: _isEdiatble,
                        isReadyOnly: true,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: descTFController,
                        errorCode: errorCode,
                        errorText: errorMessage,
                        fieldId: 1001,
                        fieldText: AppStrings.carDescription,
                        hintText: AppStrings.enterHere,
                        maxLines: 4,
                        isShowEdiatbleButton: _isEdiatble,
                        isReadyOnly: true,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: modelTFController,
                        errorCode: errorCode,
                        errorText: errorMessage,
                        fieldId: 12,
                        fieldText: AppStrings.addModel,
                        hintText: AppStrings.enterModel,
                        isShowEdiatbleButton: _isEdiatble,
                        isReadyOnly: true,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: yearTFController,
                        errorCode: errorCode,
                        errorText: errorMessage,
                        fieldId: 13,
                        fieldText: AppStrings.year,
                        hintText: AppStrings.enterYear,
                        keyboardType: TextInputType.number,
                        isShowEdiatbleButton: _isEdiatble,
                        isReadyOnly: true,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: priceTFController,
                        errorCode: errorCode,
                        errorText: errorMessage,
                        fieldId: 14,
                        fieldText: "Price",
                        hintText: AppStrings.enterPriceHour,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        isShowEdiatbleButton: _isEdiatble,
                        isReadyOnly: true,
                      ),
                      const Spacer(),
                      gapH50,
                      RoundedButton(
                        title: _isEdiatble ? "Save" : "Edit",
                        loadingText: loadingText,
                        isLoading: isLoading,
                        onPressed: () {
                          if (!_isEdiatble) {
                            setState(
                              () {
                                _isEdiatble = true;
                              },
                            );
                            return;
                          }
                          _triggerUpdateEvent(context.read<SPBloc>());
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
