import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tictictoeproject1223/src/data/board.dart';
import 'package:tictictoeproject1223/src/helper/firebase_helper.dart';
import 'package:tictictoeproject1223/src/widget/tictactoe.dart';

class GamePage extends StatefulWidget {
  final String gameId;
  const GamePage({super.key, required this.gameId});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final gameDoc = gameCol.doc(widget.gameId);
  late final gameSnapShot = gameCol.doc(widget.gameId).snapshots();
  late final chatDoc =
      FirebaseFirestore.instance.collection("msg").doc(widget.gameId);
  late var chatsnapshots = chatDoc.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: gameSnapShot,
        builder: ((context, snapshot) {
          if (snapshot.hasError) return Text(snapshot.error!.toString());
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (!snapshot.hasData) return Text("no data");
          final game = snapshot.data!.data();
          if (game == null) return Text("game is null");
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(game.player1.name),
                    CircleAvatar(
                      child:
                          ClipOval(child: Image.network(game.player1.image!)),
                    ),
                    Expanded(child: Center(child: Text("VS"))),
                    CircleAvatar(
                      child:
                          ClipOval(child: Image.network(game.player2.image!)),
                    ),
                    Text(game.player2.name)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("current BoardPlayer is ${game.board.current.name}"),
                ),
                if (game.board.winner != null)
                  Text("the winner is ${game.board.winner!.name}"),
                if (game.board.endGame && game.board.winner == null)
                  const Text("no winner"),
                BoardWidget(
                  items: game.board.items,
                  onClick: (i) {
                    if (game.board.endGame) return;
                    // player1 => o , player2 => x
                    if (game.player1.id == curentUsert.uid &&
                        game.board.current != BoardPlayer.o) {
                      return;
                    }
                    if (game.player2.id == curentUsert.uid &&
                        game.board.current != BoardPlayer.x) {
                      return;
                    }
                    if (game.board.items[i] != null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("please select empty location")));
                      return;
                    }
                    setState(() {
                      game.board.counter++;
                      game.board.items[i] = game.board.current;
                      game.board.current = game.board.current == BoardPlayer.o
                          ? BoardPlayer.x
                          : BoardPlayer.o;
                      game.board.handleWinner();
                      if (game.board.winner == null &&
                          !game.board.items.contains(null)) {
                        game.board.endGame = true;
                      }
                    });
                    gameDoc.set(game);
                  },
                ),
                TextField(
                  onChanged: (data) {
                    print(data);
                    chatDoc.set({"msg": data});
                  },
                ),
                StreamBuilder(
                    stream: chatsnapshots,
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.data() == null)
                        return Text("no data");
                      return Text(snapshot.data!.data()!["msg"]);
                    }))
              ],
            ),
          );
        }),
      ),
    );
  }
}
