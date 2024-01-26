import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTitleTextField extends StatefulWidget {
  const CustomTitleTextField({
    super.key,
    required this.fieldText,
    required this.hintText,
    this.controller,
    this.suffixWidget,
    this.onTFTap,
    this.obscureText = false,
    this.errorText,
    this.isReadyOnly = false,
    this.keyboardType,
    this.prefixWidget,
    this.maxLines = 1,
    this.minLines,
    this.isShowEdiatbleButton = false,
    this.filedId,
    this.errorCode,
    this.onSubmitted,
  });
  final String fieldText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final VoidCallback? onTFTap;
  final bool obscureText;
  final String? errorText;
  final bool isReadyOnly;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final bool isShowEdiatbleButton;
  final int? filedId;
  final int? errorCode;
  final Function(String)? onSubmitted;

  @override
  State<CustomTitleTextField> createState() => _CustomTitleTextFieldState();
}

class _CustomTitleTextFieldState extends State<CustomTitleTextField> {
  late bool _isReadOnly;
  @override
  void initState() {
    super.initState();
    _isReadOnly = widget.isReadyOnly;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldText,
          style: const TextStyle(
            color: Color(0xFF181717),
            fontSize: 10,
            fontFamily: Assets.plusJakartaFont,
            fontWeight: FontWeight.w700,
          ),
        ),
        gapH8,
        TextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          onTap: widget.onTFTap,
          keyboardType: widget.keyboardType,
          readOnly: _isReadOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onSubmitted: widget.onSubmitted != null
              ? (value) => widget.onSubmitted!(value)
              : null,
          style: StyleGuide.textStyle3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 23, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.transparent, width: 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide:
                  const BorderSide(color: StyleGuide.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (widget.maxLines > 1) ? 12 : 124,
                ),
              ),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            hintText: widget.hintText,
            hintStyle: StyleGuide.textStyle3.copyWith(
              color: const Color(0xFF6B6B6B),
            ),
            errorText:
                (widget.filedId == widget.errorCode && widget.errorText != null)
                    ? widget.errorText
                    : null,
            errorStyle: StyleGuide.textStyle3.copyWith(color: Colors.red),
            suffixIcon: widget.suffixWidget ??
                (widget.isShowEdiatbleButton
                    ? SizedBox(
                        width: 15,
                        height: 15,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isReadOnly = false;
                              });
                            },
                            icon: SvgPicture.asset(
                              Assets.penIcon,
                              width: 15,
                              height: 15,
                            ),
                          ),
                        ),
                      )
                    : null),
            prefixIcon: widget.prefixWidget,
          ),
        ),
      ],
    );
  }
}
