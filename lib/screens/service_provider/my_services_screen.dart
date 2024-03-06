import 'package:beasy/blocs/service_provider/sp_bloc.dart';
import 'package:beasy/blocs/service_provider/sp_event.dart';
import 'package:beasy/blocs/service_provider/sp_state.dart';
import 'package:beasy/models/product_model.dart';
import 'package:beasy/repositories/repos/immutable_product_repo.dart';
import 'package:beasy/screens/service_provider/components/loading_widget.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/custom_network_image.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/screens/service_provider/create_services_screen.dart';
import 'package:beasy/screens/service_provider/detail_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/error_widget.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  List<ProductModel> products = ImmutableProductRepo().products;
  bool isLoading = false;
  bool isError = false;

  Widget _getWidget() {
    if (isLoading) {
      return const LoadingWidget();
    }

    if (isError) {
      return CustomAlertWidget(
        onPressedRefresh: () {
          context.read<SPBloc>().add(SPEventFetchProducts());
        },
      );
    }

    return _MainWidget(products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SPBloc, SPState>(
      listener: (context, state) {
        if (state is SPStateFetchProductsFailure ||
            state is SPStateFetchingProducts ||
            state is SPStateProductsFetched ||
            state is SPStateUpdatedProduct ||
            state is SPStateCreatedProduct ||
            state is SPStateProductDeleted) {
          setState(() {
            isError = false;
            isLoading = state.isLoading;
            if (state is SPStateFetchProductsFailure) {
              isError = true;
            }
            if (state is SPStateUpdatedProduct ||
                state is SPStateCreatedProduct ||
                state is SPStateProductDeleted) {
              products = ImmutableProductRepo().products;
            }
            if (state is SPStateProductsFetched) {
              products = state.products;
            }
          });
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: CustomAppBar(
            title: AppStrings.allServices,
          ),
        ),
        body: SafeArea(
          child: _getWidget(),
        ),
      ),
    );
  }
}

class _MainWidget extends StatelessWidget {
  const _MainWidget(this.products);
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SPBloc>().add(SPEventFetchProducts());
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 27, right: 28, top: 30),
        child: Column(
          children: [
            Expanded(
              child: products.isEmpty
                  ? CustomAlertWidget(
                      message: "Oops! No Products",
                      onPressedRefresh: () {
                        context.read<SPBloc>().add(SPEventFetchProducts());
                      },
                    )
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: _MyServicesCard(
                            product: products[index],
                            onDeletePressed: () {
                              CustomDilaogs().deleteBox(
                                title: "Delete",
                                message:
                                    "Are you sure to delete the product ${products[index].name}?",
                                onPositivePressed: () {
                                  context.read<SPBloc>().add(
                                      SPEventDeleteProduct(atIndex: index));
                                },
                              );
                            },
                            onEditPressed: () => NavigationService.go(
                              context,
                              DetailServiceScreen(
                                isEditable: true,
                                product: products[index],
                              ),
                            ),
                            onCardPressed: () => NavigationService.go(
                              context,
                              DetailServiceScreen(
                                product: products[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            gapH20,
            RoundedButton(
              title: AppStrings.addService,
              onPressed: () =>
                  NavigationService.go(context, const CreateServiceScreen()),
            )
          ],
        ),
      ),
    );
  }
}

class _MyServicesCard extends StatelessWidget {
  final ProductModel product;

  const _MyServicesCard(
      {required this.onDeletePressed,
      required this.onEditPressed,
      required this.onCardPressed,
      required this.product});
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onCardPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardPressed,
      child: Container(
        height: 214,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: StyleGuide.backgroundColor2,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: product.images.firstOrNull ?? "",
                    height: constraints.maxHeight * 0.76,
                    width: constraints.maxWidth,
                  ),
                  Positioned(
                    top: 7,
                    right: 10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: IconButton(
                            onPressed: onDeletePressed,
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                              StyleGuide.primaryColor2,
                            )),
                            icon: SvgPicture.asset(Assets.dustBinIcon),
                          ),
                        ),
                        gapW4,
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: IconButton(
                            onPressed: onEditPressed,
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.white,
                              ),
                            ),
                            icon: SvgPicture.asset(Assets.penIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style:
                          StyleGuide.productCardStyle1.copyWith(fontSize: 14),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "\$ ${product.price}",
                        children: [
                          TextSpan(
                            text: "/Day",
                            style: StyleGuide.productCardStyle1.copyWith(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      style: StyleGuide.productCardStyle1.copyWith(
                        fontSize: 13,
                        color: StyleGuide.primaryColor2,
                      ),
                    ),
                  ],
                ),
              ),
              gapH2,
            ],
          ),
        ),
      ),
    );
  }
}
