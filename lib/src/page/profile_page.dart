import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictictoeproject1223/src/helper/pick_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                final file = await pickImageByFilePicker();
                setState(() {
                  
                });
                if (file == null) {
                  print("no image");
                  return;
                }
                final id = FirebaseAuth.instance.currentUser!.uid;
                final storageRef =
                    FirebaseStorage.instance.ref().child("user_images").child(id) ;
                final snap = await storageRef.putFile( File(file.path! )  );

                final url = await snap.ref.getDownloadURL();
                                print(url);

                await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
              },
              icon: Icon(Icons.upload))),
      body: ListView(
        children: [if (file != null) Image.file(File(file!.path))],
      ),
    );
  }
}
