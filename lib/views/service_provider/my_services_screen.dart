import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:beasy/views/service_provider/create_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.allServices,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 27, right: 28, top: 30),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _MyServicesCard(
                        onDeletePressed: () {},
                        onEditPressed: () {},
                        onCardPressed: () {},
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
      ),
    );
  }
}

class _MyServicesCard extends StatelessWidget {
  const _MyServicesCard(
      {required this.onDeletePressed,
      required this.onEditPressed,
      required this.onCardPressed});
  final VoidCallback onDeletePressed;
  final VoidCallback onEditPressed;
  final VoidCallback onCardPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCardPressed,
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
                  Image.asset(
                    Assets.demoCar,
                    height: constraints.maxHeight * 0.76,
                    width: screenWidth,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
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
                            onPressed: () => onDeletePressed,
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
                            onPressed: () => onEditPressed,
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
                      "Bentley luxury Car",
                      style:
                          StyleGuide.productCardStyle1.copyWith(fontSize: 14),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "\$ 24.0",
                        children: [
                          TextSpan(
                            text: "/Hour",
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
