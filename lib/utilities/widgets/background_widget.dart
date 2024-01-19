import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.innerWidget,
    required this.outerWidget,
    this.mediumWidget,
  });
  final Widget innerWidget;
  final Widget outerWidget;
  final Widget? mediumWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.blueBackgound),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              innerWidget,
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: mediumWidget != null ? 30 : 0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: StyleGuide.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(42),
                              topRight: Radius.circular(42),
                            ),
                          ),
                          child: outerWidget,
                        ),
                      ),
                      mediumWidget != null ? mediumWidget! : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
