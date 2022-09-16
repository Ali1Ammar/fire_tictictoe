// import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';


Future<XFile?> pickImageViaImagePicker() async {
  // does not work on macos , only for android and ios
  final imagePicker = ImagePicker();
  return await imagePicker.pickImage(source: ImageSource.gallery);
}

Future<PlatformFile?> pickImageByFilePicker() async {
  // work with all platform
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  return result?.files.first;
}
