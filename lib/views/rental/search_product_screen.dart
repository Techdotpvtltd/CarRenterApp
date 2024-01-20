import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/rental_home_widgets/small_product_card.dart';
import 'package:beasy/utilities/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key, required this.searchText});
  final String searchText;

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.searchText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.search,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            SearchWidget(
              controller: _controller,
              hintText: AppStrings.searchVechile,
              horizontalPadding: 0,
            ),
            gapH10,
            Expanded(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: ((context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: SmallProductCard(
                        url: Assets.demoCar,
                        title: "Buggati",
                        rating: 12,
                        price: 190.1,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
