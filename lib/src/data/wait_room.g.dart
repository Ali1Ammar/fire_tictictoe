// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wait_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitRoom _$WaitRoomFromJson(Map<String, dynamic> json) => WaitRoom(
      json['status'] as String,
      json['name'] as String,
      json['photo'] as String?,
      json['gameId'] as String?,
    );

Map<String, dynamic> _$WaitRoomToJson(WaitRoom instance) => <String, dynamic>{
      'status': instance.status,
      'name': instance.name,
      'photo': instance.photo,
      'gameId': instance.gameId,
    };
