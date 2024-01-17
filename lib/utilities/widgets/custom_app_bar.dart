import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.actions = const [],
    this.isShodowApply = true,
    required this.onPressed,
  });
  final String? title;
  final List<Widget> actions;
  final bool isShodowApply;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: onPressed,
            child: Container(
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
              ),
            ),
          ),
          titleSpacing: 12,
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
