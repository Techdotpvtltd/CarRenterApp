import 'package:beasy/utilities/constants/asstes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/style_guide.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onCompleted,
    this.controller,
    this.horizontalPadding = 8,
    this.shadows,
  });

  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onCompleted;
  final TextEditingController? controller;
  final double horizontalPadding;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        height: 53,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(54)),
          boxShadow: shadows ??
              <BoxShadow>[
                BoxShadow(
                  offset: const Offset(7, 7),
                  blurRadius: 36.3,
                  color: Colors.black.withAlpha(10),
                  spreadRadius: 0,
                ),
              ],
        ),
        child: Center(
          child: TextField(
            maxLines: 1,
            controller: controller,
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            onEditingComplete: onCompleted,
            clipBehavior: Clip.hardEdge,
            style:
                StyleGuide.textStyle3.copyWith(color: const Color(0xFF2C2C2C)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(54)),
              ),
              hintText: hintText,
              hintStyle: StyleGuide.textStyle3
                  .copyWith(color: const Color(0xFFBFBFBF)),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: SvgPicture.asset(Assets.magnifier),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
