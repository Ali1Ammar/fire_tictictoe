import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker_plus/image_picker_plus.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                ImagePickerPlus picker = ImagePickerPlus(context);

                SelectedImagesDetails? details =
                    await picker.pickImage(source: ImageSource.gallery);
                print(details!.selectedFiles.first.selectedFile);
                // if (details != null) await displayDetails(details);
                // final imagePicker = ImagePicker();
                // final image =
                //     await imagePicker.pickImage(source: ImageSource.gallery);
                // if (image == null) {
                //   print("no image");
                //   return;
                // }
                // final storageRef =
                //     FirebaseStorage.instance.ref().child("user_images");
                // final snap = await storageRef.putFile(File(image.path));
                // final url = await snap.ref.getDownloadURL();
                // await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
              },
              icon: Icon(Icons.upload))),
    );
  }
}
