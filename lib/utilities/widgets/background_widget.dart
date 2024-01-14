import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.innerWidget,
    required this.outerWidget,
  });
  final Widget innerWidget;
  final Widget outerWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.blueBackgound,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                innerWidget,
                Expanded(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
