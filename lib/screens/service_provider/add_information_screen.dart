import 'package:beasy/blocs/service_provider/sp_bloc.dart';
import 'package:beasy/blocs/service_provider/sp_event.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/constants/strings.dart';
import '../../utilities/constants/style_guide.dart';
import '../../utilities/widgets/custom_app_bar.dart';

class AddInformationScreen extends StatefulWidget {
  const AddInformationScreen({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<AddInformationScreen> createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  String? errorMessage;
  int? errorCode;
  bool isLoading = false;
  String loadingText = '';

  final TextEditingController modelTFController = TextEditingController();
  final TextEditingController yearTFController = TextEditingController();
  final TextEditingController priceTFController = TextEditingController();

  void _createService(SPBloc bloc) {
    setState(() {
      errorCode = null;
      errorMessage = null;
    });
    final int year = int.tryParse(yearTFController.text) ?? 0;
    final double price = double.tryParse(priceTFController.text) ?? 0;
    final ProductModel model = widget.productModel
        .copyWith(model: modelTFController.text, price: price, year: year);
    bloc.add(SPEventCreateProduct(model: model));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SPBloc, SPState>(
      listener: (context, state) {
        if (state is SPStateCreatingProduct ||
            state is SPStateCreateProductFailure ||
            state is SPStateCreatedProduct ||
            state is SPStateUploadingImage ||
            state is SPStateUploadedImage) {
          setState(() {
            loadingText = state.loadingText;
            isLoading = state.isLoading;
          });

          if (state is SPStateCreateProductFailure) {
            if (state.exception.errorCode != null) {
              setState(() {
                errorCode = state.exception.errorCode;
                errorMessage = state.exception.message;
              });
              return;
            }
            CustomDilaogs().errorBox(message: state.exception.message);
          }

          if (state is SPStateCreatedProduct) {
            CustomDilaogs().successBox(
              message: "Congratulation!\nYour service is live.",
              barrierDismissible: false,
              onPositivePressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              positiveTitle: "Go to Home",
            );
          }
        }
      },

      /// Widgets
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),

          /// App Bar
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
                /// Add Model TF
                CustomTitleTextField(
                  controller: modelTFController,
                  errorCode: errorCode,
                  errorText: errorMessage,
                  fieldId: 12,
                  fieldText: AppStrings.addModel,
                  hintText: AppStrings.enterModel,
                ),
                gapH22,
                CustomTitleTextField(
                  controller: yearTFController,
                  errorCode: errorCode,
                  errorText: errorMessage,
                  fieldId: 13,
                  fieldText: AppStrings.year,
                  hintText: AppStrings.enterYear,
                  keyboardType: TextInputType.number,
                ),
                gapH22,
                CustomTitleTextField(
                  controller: priceTFController,
                  errorCode: errorCode,
                  errorText: errorMessage,
                  fieldId: 14,
                  fieldText: "Price",
                  hintText: AppStrings.enterPriceHour,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const Spacer(),
                RoundedButton(
                  title: AppStrings.upload,
                  loadingText: loadingText,
                  isLoading: isLoading,
                  onPressed: () {
                    _createService(context.read<SPBloc>());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
