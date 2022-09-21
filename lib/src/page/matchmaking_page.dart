import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tictictoeproject1223/src/data/board.dart';
import 'package:tictictoeproject1223/src/data/game.dart';
import 'package:tictictoeproject1223/src/data/player.dart';
import 'package:tictictoeproject1223/src/data/wait_room.dart';
import 'package:tictictoeproject1223/src/helper/firebase_helper.dart';
import 'package:tictictoeproject1223/src/helper/route_helper.dart';
import 'package:tictictoeproject1223/src/page/game_page.dart';
import 'package:tictictoeproject1223/src/widget/tictactoe.dart';

class MatchMakingPage extends StatefulWidget {
  const MatchMakingPage({super.key});

  @override
  State<MatchMakingPage> createState() => _MatchMakingPageState();
}

class _MatchMakingPageState extends State<MatchMakingPage> {
  final myDoc = waitRoom.doc(curentUsert.uid);

  @override
  initState() {
    waitPlayer();
    findPlayer();
    super.initState();
  }

  waitPlayer() async {
    await myDoc.set(WaitRoom(
        curentUsert.uid, curentUsert.displayName!, curentUsert.photoURL, null));
    myDoc.snapshots().listen((event) {
      if (event.data()!.status == "done") {
        goToPage(context, GamePage(gameId: event.data()!.gameId! ,));
      }
    });
  }

  findPlayer() async {
    final players = await waitRoom
        .where("status", whereNotIn: ["done", curentUsert.uid])
        .limit(1)
        .get();
    if (players.docs.isEmpty) return;
    final otherPlayerRef = players.docs.first;
    final transRes = await FirebaseFirestore.instance
        .runTransaction<Map<String, dynamic>?>((transaction) async {
      final otherPlayer = await transaction.get(otherPlayerRef.reference);
      if (otherPlayer.data()!.status == "done") return null;
      final player = await transaction.get(myDoc);
      if (player.data()!.status == "done") return null;
      final gameId = player.id + otherPlayer.id;
      transaction.update(
          otherPlayerRef.reference, {"status": "done", "gameId": gameId});
      transaction.update(myDoc, {"status": "done", "gameId": gameId});
      return {
        "gameId": gameId,
        "player": Player(
            otherPlayer.data()!.name, otherPlayer.data()!.photo, otherPlayer.id)
      };
    });
    if (transRes == null) {
      return findPlayer();
    }
    gameCol.doc(transRes["gameId"]).set(Game(
        transRes["gameId"],
        Player(curentUsert.displayName!, curentUsert.photoURL, curentUsert.uid),
        transRes["player"], Board()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
                width: 100, height: 100, child: CircularProgressIndicator()),
          ),
          Text("waiting player")
        ],
      ),
    );
  }
}
