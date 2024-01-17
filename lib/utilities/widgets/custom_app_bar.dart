import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';

import '../navigation_service.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.isShodowApply = true,
    this.onPressed,
  });
  final String? title;
  final List<Widget>? actions;
  final bool isShodowApply;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: Center(
            child: InkWell(
              onTap: onPressed ?? () => NavigationService.back(context),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  boxShadow: isShodowApply
                      ? [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            offset: const Offset(5.25, 5.25),
                            blurRadius: 27.22,
                          ),
                        ]
                      : [],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
              ),
            ),
          ),
          titleSpacing: 12,
          leadingWidth: 54,
          automaticallyImplyLeading: false,
          title: Text(
            title ?? "",
            style: const TextStyle(
              fontFamily: Assets.poppinsFont,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
          actions: actions,
        ),
      ),
    );
  }
}
