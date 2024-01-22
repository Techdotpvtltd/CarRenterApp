import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyServicesScreen extends StatelessWidget {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: AppStrings.allServices,
        ),
      ),
    );
  }
}
