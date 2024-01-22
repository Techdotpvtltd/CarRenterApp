import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

import '../navigation_service.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.isShodowApply = true,
    this.onPressedPrefix,
    this.prefixWidet,
    this.isBackButtonVisible = true,
    this.isBackButtonBackgroundVisible = true,
    this.titleSpace = 12,
    this.isVisible = true,
    this.isCenteredTitle = false,
    this.titleColor,
  });
  final String? title;
  final List<Widget>? actions;
  final bool isShodowApply;
  final VoidCallback? onPressedPrefix;
  final Widget? prefixWidet;
  final bool isBackButtonVisible;
  final bool isBackButtonBackgroundVisible;
  final double titleSpace;
  final bool isVisible;
  final bool isCenteredTitle;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: isCenteredTitle,
          leading: isBackButtonVisible
              ? Center(
                  child: InkWell(
                    onTap: onPressedPrefix ??
                        () => NavigationService.back(context),
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        color: prefixWidet != null ||
                                !isBackButtonBackgroundVisible
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
                      child: prefixWidet ??
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
            style: TextStyle(
              fontFamily: Assets.poppinsFont,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: titleColor ?? StyleGuide.textColor2,
            ),
          ),
          actions: actions,
        ),
      ),
    );
  }
}
