// import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageViaImagePicker() async {
  // does not work on macos , only for android and ios
  final ima = ImagePicker();
  return ima.pickImage(source: ImageSource.gallery);
}

Future<PlatformFile?> pickImageByFilePicker() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image );
  return image?.files.first;
}
