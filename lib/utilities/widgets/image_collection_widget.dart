import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageCollectionWidget extends StatelessWidget {
  const ImageCollectionWidget(
      {super.key,
      this.height,
      required this.images,
      this.onClickDeleteButton,
      this.onClickCard,
      required this.onClickUploadCard,
      this.isShowUploadButton = true});
  final double? height;
  final List<String> images;
  final Function(int index)? onClickDeleteButton;
  final Function(int index)? onClickCard;
  final Function(int index) onClickUploadCard;
  final bool isShowUploadButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.addImages,
          style: StyleGuide.serviceProviderStyle2,
        ),
        gapH16,
        Expanded(
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) {
              return GridView.builder(
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    mainAxisExtent: (height ?? constraints.maxWidth - 30) / 2),
                itemCount: (images.length >= 4)
                    ? 4
                    : isShowUploadButton
                        ? (images.length + 1)
                        : images.length,
                itemBuilder: (_, index) {
                  return (index < images.length)
                      ? InkWell(
                          onTap: onClickCard != null
                              ? () => onClickCard!(index)
                              : null,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                child: Image.asset(
                                  images[index],
                                  height: (height ?? constraints.maxHeight) / 2,
                                  width: (constraints.maxWidth) / 2,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Visibility(
                                visible: onClickDeleteButton != null,
                                child: Positioned(
                                  top: 7,
                                  right: 15,
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: IconButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.redAccent),
                                      ),
                                      icon:
                                          SvgPicture.asset(Assets.dustBinIcon),
                                      onPressed: () =>
                                          onClickDeleteButton!(index),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () => onClickUploadCard(index),
                          splashColor: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: StyleGuide.backgroundColor2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: SvgPicture.asset(Assets.uploadIcon),
                            ),
                          ),
                        );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
