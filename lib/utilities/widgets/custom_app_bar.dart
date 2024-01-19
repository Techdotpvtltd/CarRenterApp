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
    this.suffixIcon,
    this.isBackButtonVisible = true,
    this.isBackButtonBackgroundVisible = true,
    this.titleSpace = 12,
    this.isVisible = true,
  });
  final String? title;
  final List<Widget>? actions;
  final bool isShodowApply;
  final VoidCallback? onPressed;
  final Widget? suffixIcon;
  final bool isBackButtonVisible;
  final bool isBackButtonBackgroundVisible;
  final double titleSpace;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: isBackButtonVisible
              ? Center(
                  child: InkWell(
                    onTap: onPressed ?? () => NavigationService.back(context),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color:
                            suffixIcon != null || !isBackButtonBackgroundVisible
                                ? Colors.transparent
                                : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
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
                      child: suffixIcon ??
                          const Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                    ),
                  ),
                )
              : null,
          titleSpacing: titleSpace,
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
