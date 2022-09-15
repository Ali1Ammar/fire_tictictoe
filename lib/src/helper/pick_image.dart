// import 'dart:io';

// import 'package:file_selector/file_selector.dart';
// import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

// pickImage() {
//   if (kIsWeb || Platform.isAndroid) return pickImageViaImagePicker();
//   if (Platform.isIOS && kReleaseMode) return pickImageViaImagePicker();
//   return pickImageViaFileSelector();
// }

Future<XFile?> pickImageViaImagePicker() async {
  final imagePicker = ImagePicker();
  return await imagePicker.pickImage(source: ImageSource.gallery);
}

// Future<XFile?> pickImageViaFileSelector() async {
//   final XTypeGroup typeGroup = XTypeGroup(
//     label: 'images',
//     extensions: <String>['jpg', 'png'],
//   );
//   return await openFile(acceptedTypeGroups: [typeGroup]);
// }
