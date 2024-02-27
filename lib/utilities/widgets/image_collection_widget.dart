import 'dart:io';

import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/my_image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ImageCollectionWidget extends StatelessWidget {
  const ImageCollectionWidget(
      {super.key,
      this.height,
      required this.images,
      this.onClickDeleteButton,
      this.onClickCard,
      required this.onClickUploadImage,
      this.isShowUploadButton = true,
      required this.title});
  final double? height;
  final List<String> images;
  final Function(int index)? onClickDeleteButton;
  final Function(int index)? onClickCard;
  final Function(XFile file) onClickUploadImage;
  final bool isShowUploadButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: images[index],
                                  errorListener: (value) {},
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      url != "" &&
                                              error.toString().contains(
                                                  "No host specified in URI")
                                          ? Image.file(
                                              File(images[index]),
                                              height: (height ??
                                                      constraints.maxHeight) /
                                                  2,
                                              width: (constraints.maxWidth) / 2,
                                              fit: BoxFit.cover,
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 32,
                                              ),
                                            ),
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
                          onTap: () {
                            final MyImagePicker imagePicker =
                                MyImagePicker(imageQuality: 50);
                            imagePicker.pick();
                            imagePicker.onSelection((exception, data) {
                              if (data != null) {
                                onClickUploadImage(data);
                              }
                            });
                          },
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
