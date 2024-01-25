// import 'dart:io';

// import 'package:beasy/utilities/constants/style_guide.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../main.dart';

// enum ActionStyle { normal, destructive, important, importantDestructive }

// enum ImageQuality {
//   high(100),
//   medium(75),
//   low(50);

//   const ImageQuality(this.percentage);
//   final int percentage;
// }

// class CustomDialog extends StatelessWidget {
//   final String? title, description, buttonText;
//   final Image? image;
//   final Function? function;

//   const CustomDialog(
//       {super.key,
//       this.title,
//       this.description,
//       this.buttonText,
//       this.image,
//       this.function});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }

//   dialogContent(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//             padding: const EdgeInsets.only(
//                 top: 100, bottom: 16, left: 16, right: 16),
//             margin: const EdgeInsets.only(top: 16),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(17),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10.0,
//                     offset: Offset(0.0, 10.0),
//                   )
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   title ?? "",
//                   style: const TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 24.0),
//                 Text(description ?? "", style: const TextStyle(fontSize: 16)),
//                 const SizedBox(height: 24.0),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: TextButton(
//                     onPressed: () {
//                       if (function != null) {
//                         function!.call();
//                       } else {
//                         Navigator.pop(context);
//                       }
//                     },
//                     child: Text(buttonText ?? ""),
//                   ),
//                 )
//               ],
//             )),
//         Positioned(
//             top: 0,
//             left: 16,
//             right: 16,
//             child: CircleAvatar(
//               backgroundColor: Colors.blueAccent,
//               radius: 50,
//               child: ClipOval(
//                 child: image,
//               ),
//             ))
//       ],
//     );
//   }
// }

// // ignore: must_be_immutable
// class CameraGalleryBottomSheet extends StatelessWidget {
//   Function? cameraClick;
//   Function? galleryClick;
//   Function(File? file)? onFileSelected;

//   CameraGalleryBottomSheet({super.key, this.cameraClick, this.galleryClick});

//   File? file;
//   final picker = ImagePicker();

//   Future getImage(ImageSource imageSource, BuildContext context) async {
//     final pickedFile = await picker.pickImage(source: imageSource);
//     if (pickedFile != null) {
//       file = File(pickedFile.path);
//       // onFileSelected.call(file);
//       ImageProperties properties =
//           await FlutterNativeImage.getImageProperties(file!.path);
//       File compressedFile = await FlutterNativeImage.compressImage(file!.path,
//           quality: 100,
//           targetWidth: 900,
//           targetHeight: (properties.height! * 900 / properties.width!).round());

//       // ignore: use_build_context_synchronously
//       Navigator.pop(context, compressedFile);
//     } else {
//       onFileSelected?.call(null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20, top: 30),
//       height: 250,
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             onTap: () {
//               //cameraClick.call();
//               getImage(ImageSource.camera, context);
//             },
//             leading: const Icon(
//               CupertinoIcons.camera,
//               size: 30,
//               color: StyleGuide.primaryColor2,
//             ),
//             title: const Text(
//               'Camera',
//               style: TextStyle(fontSize: 20, color: StyleGuide.primaryColor2),
//             ),
//             subtitle: const Text(
//               'pick image from camera',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               // galleryClick.call();
//               getImage(ImageSource.gallery, context);
//               // Navigator.pop(context);
//             },
//             leading: const Icon(
//               Icons.abc,
//               size: 30,
//               color: StyleGuide.primaryColor2,
//             ),
//             title: const Text(
//               'Gallery',
//               style: TextStyle(fontSize: 20, color: StyleGuide.primaryColor2),
//             ),
//             subtitle: const Text(
//               'Click To PickImageGallery',
//               style: TextStyle(color: Colors.grey),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class VideoGalleryBottomSheet extends StatelessWidget {
//   Function? cameraClick;
//   Function? galleryClick;
//   Function(File? file)? onFileSelected;

//   VideoGalleryBottomSheet({super.key, this.cameraClick, this.galleryClick});

//   File? file;
//   final picker = ImagePicker();

//   Future getImage(ImageSource imageSource, BuildContext context,
//       {ImageQuality imageQuality = ImageQuality.low}) async {
//     final pickedFile = await picker.pickImage(source: imageSource);
//     if (pickedFile != null) {
//       file = File(pickedFile.path);
//       // onFileSelected.call(file);
//       ImageProperties properties =
//           await FlutterNativeImage.getImageProperties(file!.path);
//       File compressedFile = await FlutterNativeImage.compressImage(file!.path,
//           quality: imageQuality.percentage,
//           targetWidth: 900,
//           targetHeight: (properties.height! * 900 / properties.width!).round());
//       Navigator.pop(navKey.currentContext ?? context, compressedFile);
//     } else {
//       debugPrint('No image selected.');
//       onFileSelected?.call(null);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20, top: 30),
//       height: 250,
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             onTap: () {
//               //cameraClick.call();
//               _getVideo(ImageSource.camera, context);
//             },
//             leading: const Icon(
//               Icons.video_camera_back,
//               size: 30,
//               color: StyleGuide.primaryColor2,
//             ),
//             title: const Text(
//               'Video',
//               style: TextStyle(fontSize: 20, color: StyleGuide.primaryColor2),
//             ),
//             subtitle: const Text(
//               'Video Form Camera',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//           ListTile(
//             onTap: () {
//               // galleryClick.call();
//               _getVideo(ImageSource.gallery, context);
//               // Navigator.pop(context);
//             },
//             leading: const Icon(
//               Icons.video_camera_front,
//               size: 30,
//               color: StyleGuide.primaryColor2,
//             ),
//             title: const Text(
//               'Video',
//               style: TextStyle(fontSize: 20, color: StyleGuide.primaryColor2),
//             ),
//             subtitle: const Text(
//               'From Gralley',
//               style: TextStyle(color: Colors.grey),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// Future<File?> kImagePicker(BuildContext context,
//     {String title = "Choose value",
//     String message = "",
//     ImageQuality imageQuality = ImageQuality.medium}) async {
//   if (Platform.isAndroid) {
//     return await showModalBottomSheet(
//         context: context, builder: (context) => CameraGalleryBottomSheet());
//   }
//   debugPrint("openinig");
//   var input =
//       await showModalActionSheet(context: context, title: title, actions: [
//     const SheetAction(label: 'Take Photo', key: "0"),
//     const SheetAction(label: 'From Gralley', key: "1")
//   ]);
//   if (input?.isEmpty ?? true) return null;
//   return _getImage(input == "0" ? ImageSource.camera : ImageSource.gallery,
//       navKey.currentContext!);
// }

// Future<File?> kImagePickerFromCamera(BuildContext context,
//     {ImageQuality imageQuality = ImageQuality.medium}) async {
//   return _getImage(ImageSource.camera, navKey.currentContext!);
// }

// Future<File?> _getImage(ImageSource imageSource, BuildContext context,
//     {ImageQuality imageQuality = ImageQuality.medium}) async {
//   File file;
//   final picker = ImagePicker();

//   final pickedFile = await picker.pickImage(source: imageSource);

//   if (pickedFile != null) {
//     file = File(pickedFile.path);
//     ImageProperties properties =
//         await FlutterNativeImage.getImageProperties(file.path);
//     File compressedFile = await FlutterNativeImage.compressImage(file.path,
//         quality: imageQuality.percentage,
//         targetWidth: 900,
//         targetHeight: (properties.height! * 900 / properties.width!).round());
//     debugPrint("***************************************");
//     debugPrint(compressedFile.toString());
//     debugPrint("***************************************");

//     return compressedFile;
//   } else {
//     debugPrint('No image selected.');
//     return null;
//   }
// }

// /////////////////////

// Future<File?> kVideoPicker(
//   BuildContext context, {
//   String title = "Choose value",
//   String message = "",
// }) async {
//   if (Platform.isAndroid) {
//     return await showModalBottomSheet(
//         context: context, builder: (context) => VideoGalleryBottomSheet());
//   }
//   debugPrint("openinig");
//   var input =
//       await showModalActionSheet(context: context, title: title, actions: [
//     const SheetAction(label: 'Take Photo', key: "1"),
//     const SheetAction(label: 'From Gralley', key: "1")
//   ]);
//   if (input?.isEmpty ?? true) return null;
//   return input == "0"
//       ? _getImage(ImageSource.gallery, navKey.currentContext ?? context)
//       : _getVideo(ImageSource.gallery, navKey.currentContext ?? context);
// }

// Future<File?> _getVideo(ImageSource imageSource, BuildContext context) async {
//   File file;
//   final picker = ImagePicker();

//   final pickedFile = await picker.pickVideo(
//       source: imageSource, maxDuration: const Duration(seconds: 15));
//   if (pickedFile == null) {
//     return File('');
//   }

//   file = File(pickedFile.path);
//   debugPrint("***************************************");
//   debugPrint("***************************************");
//   Navigator.pop(navKey.currentContext ?? context, file);
//   return file;
// }
