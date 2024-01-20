import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class AllBrandScreen extends StatefulWidget {
  const AllBrandScreen({super.key});

  @override
  State<AllBrandScreen> createState() => _AllBrandScreenState();
}

class _AllBrandScreenState extends State<AllBrandScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.allBrand,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 33, 25, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchWidget(
              hintText: AppStrings.searchVehicleOrBrands,
              horizontalPadding: 0,
            ),
            gapH20,
            const Text(
              AppStrings.allBrand,
              style: TextStyle(
                fontFamily: Assets.poppinsFont,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: StyleGuide.textColor2,
              ),
            ),
            gapH8,
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 6),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? StyleGuide.primaryColor2
                            : StyleGuide.backgroundColor2,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    Assets.demoBrandLogo,
                                    width: 30,
                                  ),
                                ),
                                gapW8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BMW",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          StyleGuide.productCardStyle1.copyWith(
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : StyleGuide.textColor2,
                                      ),
                                    ),
                                    gapH4,
                                    Text(
                                      "32 cars available",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          StyleGuide.productCardStyle1.copyWith(
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : StyleGuide.textColor2,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
