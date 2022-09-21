// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => Board(
      winner: $enumDecodeNullable(_$BoardPlayerEnumMap, json['winner']),
      counter: json['counter'] as int? ?? 0,
      current: $enumDecodeNullable(_$BoardPlayerEnumMap, json['current']) ??
          BoardPlayer.o,
      endGame: json['endGame'] as bool? ?? false,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => $enumDecodeNullable(_$BoardPlayerEnumMap, e))
              .toList() ??
          const [null, null, null, null, null, null, null, null, null],
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'items': instance.items.map((e) => _$BoardPlayerEnumMap[e]).toList(),
      'current': _$BoardPlayerEnumMap[instance.current]!,
      'winner': _$BoardPlayerEnumMap[instance.winner],
      'endGame': instance.endGame,
      'counter': instance.counter,
    };

const _$BoardPlayerEnumMap = {
  BoardPlayer.x: 'x',
  BoardPlayer.o: 'o',
};
