import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tictictoeproject1223/src/helper/pick_image.dart';
import 'package:tictictoeproject1223/src/helper/route_helper.dart';
import 'package:tictictoeproject1223/src/page/matchmaking_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    final isHavePhoto = FirebaseAuth.instance.currentUser!.photoURL != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.displayName!),
      ),
      body: ListView(
        children: [
          if (isHavePhoto)
            Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
          Text(FirebaseAuth.instance.currentUser!.email!),
          TextButton(
              onPressed: () async {
                final image = await pickImageByFilePicker();
                file = image;
                setState(() {});
                final ref = FirebaseStorage.instance
                    .ref("images")
                    .child(FirebaseAuth.instance.currentUser!.uid);
                final snapImage = await ref.putFile(File(file!.path!));
                final url = await snapImage.ref.getDownloadURL();

                await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("complete uploading")));
              },
              child: isHavePhoto
                  ? Text("Edit your photo")
                  : Text("upload a new photo")),
          if (file != null) Image.file(File(file!.path!)),
          OutlinedButton(
              onPressed: () {
                goToPage(context, const MatchMakingPage());
              },
              child: Text("play tictactoe"))
        ],
      ),
    );
  }
}
