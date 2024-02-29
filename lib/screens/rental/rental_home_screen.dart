import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/blocs/rental/rental_product_bloc.dart';
import 'package:beasy/blocs/rental/rental_product_state.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/background_widget.dart';
import 'package:beasy/utilities/widgets/network_image_widget.dart';
import 'package:beasy/screens/rental/components/product_card.dart';
import 'package:beasy/screens/rental/components/product_section_widget.dart';
import 'package:beasy/utilities/widgets/search_widget.dart';
import 'package:beasy/screens/rental/all_brand_screen.dart';
import 'package:beasy/screens/rental/product_detail_screen.dart';
import 'package:beasy/screens/rental/product_screen.dart';
import 'package:beasy/screens/rental/search_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/rental/rental_product_event.dart';
import '../../models/product_model.dart';
import '../../repositories/repos/immutable_product_repo.dart';
import '../service_provider/components/error_widget.dart';
import '../service_provider/components/loading_widget.dart';

class RentalHomeScreen extends StatefulWidget {
  const RentalHomeScreen({super.key});

  @override
  State<RentalHomeScreen> createState() => _RentalHomeScreenState();
}

class _RentalHomeScreenState extends State<RentalHomeScreen> {
  int _selectedBrand = 0;
  UserModel? _userModel;
  bool isLoading = false;
  bool isError = false;
  List<ProductModel> products = ImmutableProductRepo().products;

  Widget _getWidget() {
    if (isLoading) {
      return LoadingWidget(
        height: screenHeight / 3,
      );
    }

    if (isError) {
      return CustomAlertWidget(
        height: screenHeight / 3,
        onPressedRefresh: () {
          context.read<RentalProductBloc>().add(RentalEventFetchProducts());
        },
      );
    }

    return _MainWidget(products);
  }

  @override
  void initState() {
    if (!UserRepo().isUserNull) {
      _userModel = UserRepo().currentUser;
      context.read<RentalProductBloc>().add(RentalEventFetchProducts());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RentalProductBloc, RentalProductState>(
      listener: (context, state) {
        if (state is RentalStateFetchProductsFailure ||
            state is RentalStateFetchingProducts ||
            state is RentalStateProductsFetched) {
          setState(() {
            isError = false;
            isLoading = state.isLoading;
            if (state is RentalStateFetchProductsFailure) {
              isError = true;
            }

            if (state is RentalStateProductsFetched) {
              products = state.products;
            }
          });
        }
      },
      child: BackgroundWidget(
        topWidget: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<DrawerCubit>().openDrawer();
                    },
                    child: Image.asset(
                      "assets/icons/draw.png",
                      height: 16,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/icons/pin2.png",
                    height: 16,
                  ),
                  gapW10,
                  Text(
                    "${_userModel?.location.city}, ${_userModel?.location.country}",
                    style: const TextStyle(
                      fontFamily: Assets.plusJakartaFont,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: StyleGuide.textColor1,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleNetworkImage(url: _userModel?.imageUrl ?? ""),
                  ),
                ],
              ),
              gapH32,
              const Text(
                "Pick up Your favorite\nCar for rent.",
                style: TextStyle(
                  color: StyleGuide.textColor1,
                  fontFamily: Assets.poppinsFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
        mediumWidget: SearchWidget(
          hintText: AppStrings.searchVechile,
          onSubmitted: (str) => NavigationService.go(
              context,
              SearchProductScreen(
                searchText: str,
              )),
          shadows: <BoxShadow>[
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withAlpha(25),
              spreadRadius: 0,
            ),
          ],
        ),
        bottomWidget: RefreshIndicator(
          onRefresh: () async {
            context.read<RentalProductBloc>().add(RentalEventFetchProducts());
          },
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 36, 28, 90),
              child: Column(
                children: [
                  ProductSectionWidget(
                    products: products,
                    title: AppStrings.topBrands,
                    itemCount: 10,
                    cardHeight: 40,
                    onPressedAll: () {
                      NavigationService.go(context, const AllBrandScreen());
                    },
                    onPressedProduct: (index) {
                      setState(
                        () {
                          _selectedBrand = index;
                        },
                      );
                    },
                    builder: (index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedBrand == index
                            ? StyleGuide.primaryColor2
                            : Colors.white,
                        border: Border.all(
                          color: _selectedBrand == index
                              ? StyleGuide.primaryColor2
                              : const Color(0xFFBFBFBF),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(78)),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.bmwIcon,
                            height: 21,
                            width: 21,
                            fit: BoxFit.contain,
                          ),
                          gapW6,
                          Text(
                            "BMW",
                            style: StyleGuide.onboardingText1.copyWith(
                              color: _selectedBrand == index
                                  ? Colors.white
                                  : StyleGuide.textColor2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  _getWidget(),
                ],
              ),
            ),
          ),
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
    return Column(
      children: [
        gapH18,
        ProductSectionWidget(
          products: products,
          title: AppStrings.availableNearYour,
          onPressedAll: () {
            NavigationService.go(
              context,
              ProductScreen(
                products: products,
              ),
            );
          },
          itemCount: products.length,
          onPressedProduct: (index) {
            NavigationService.go(
              context,
              ProductDetailScreen(
                product: products[index],
              ),
            );
          },
          builder: (index) => ProductCard(
            product: products[index],
            width: 167,
          ),
          cardHeight: 170,
        ),
        gapH18,
        ProductSectionWidget(
          products: products,
          title: AppStrings.topDeals,
          onPressedAll: () {
            NavigationService.go(
              context,
              ProductScreen(
                products: products,
              ),
            );
          },
          itemCount: 5,
          onPressedProduct: (index) {
            NavigationService.go(
              context,
              ProductDetailScreen(
                product: products[index],
              ),
            );
          },
          builder: (index) => ProductCard(
            product: products[index],
            width: 167,
          ),
          cardHeight: 170,
        ),
      ],
    );
  }
}
