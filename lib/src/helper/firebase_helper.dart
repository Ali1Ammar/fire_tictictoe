import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictictoeproject1223/src/data/game.dart';
import 'package:tictictoeproject1223/src/data/wait_room.dart';

User get curentUsert => FirebaseAuth.instance.currentUser!;

final waitRoom = FirebaseFirestore.instance
    .collection("waitroom")
    .withConverter(fromFirestore: (data, _) {
  return WaitRoom.fromJson(data.data()!);
}, toFirestore: (data, _) {
  return data.toJson();
});

final gameCol = FirebaseFirestore.instance.collection("games").withConverter(
    fromFirestore: (data, _) {
  return Game.fromJson(data.data()!);
}, toFirestore: (data, _) {
  return data.toJson();
});
