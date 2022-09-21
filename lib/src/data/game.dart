import 'package:json_annotation/json_annotation.dart';
import 'package:tictictoeproject1223/src/data/player.dart';

import 'board.dart';

part "game.g.dart";

@JsonSerializable(explicitToJson: true)
class Game {
  final String id;
  final Player player1;
  final Player player2;
  final Board board;
  Game(this.id, this.player1, this.player2, this.board);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}
