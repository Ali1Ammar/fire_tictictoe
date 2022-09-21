import 'package:json_annotation/json_annotation.dart';

part "board.g.dart";

enum BoardPlayer { x, o }

@JsonSerializable()
class Board {
  List<BoardPlayer?> items;
  BoardPlayer current;
  BoardPlayer? winner;
  bool endGame;
  int counter;
  Board(
      {this.winner,
      this.counter = 0,
      this.current = BoardPlayer.o,
      this.endGame = false,
      this.items = const [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ]});

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
  Map<String, dynamic> toJson() => _$BoardToJson(this);

  handleWinner() {
    const winnerCase = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var element in winnerCase) {
      final fItem = items[element[0]];
      final sItem = items[element[1]];
      final tItem = items[element[2]];
      if (fItem == sItem && fItem == tItem && fItem != null) {
        winner = fItem;
        endGame = true;
        break;
      }
    }
  }
}
