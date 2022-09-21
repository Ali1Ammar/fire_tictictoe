import 'package:json_annotation/json_annotation.dart';

part "wait_room.g.dart";

@JsonSerializable()
class WaitRoom {
  final String status;
  final String name;
  final String? photo;
  final String? gameId;
  WaitRoom(this.status, this.name, this.photo, this.gameId);

  factory WaitRoom.fromJson(Map<String, dynamic> json) =>
      _$WaitRoomFromJson(json);
  Map<String, dynamic> toJson() => _$WaitRoomToJson(this);
}
