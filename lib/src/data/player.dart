import 'package:json_annotation/json_annotation.dart';

part "player.g.dart";

@JsonSerializable()
class Player {
  final String name;
  final String? image;
  final String id;
  Player(this.name, this.image, this.id);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
