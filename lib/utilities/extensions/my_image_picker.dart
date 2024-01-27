import 'package:image_picker/image_picker.dart';

class MyImagePicker {
  Future<String> pick() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    return image?.path ?? "";
  }
}
