// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['id'] as String,
      Player.fromJson(json['player1'] as Map<String, dynamic>),
      Player.fromJson(json['player2'] as Map<String, dynamic>),
      Board.fromJson(json['board'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'player1': instance.player1.toJson(),
      'player2': instance.player2.toJson(),
      'board': instance.board.toJson(),
    };
