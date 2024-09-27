// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DexPoolHiveAdapter extends TypeAdapter<DexPoolHive> {
  @override
  final int typeId = 5;

  @override
  DexPoolHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPoolHive(
      poolAddress: fields[0] as String,
      lpToken: fields[1] as DexTokenHive,
      pair: fields[2] as DexPairHive,
      lpTokenInUserBalance: fields[3] as bool,
      isFavorite: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DexPoolHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.poolAddress)
      ..writeByte(1)
      ..write(obj.lpToken)
      ..writeByte(2)
      ..write(obj.pair)
      ..writeByte(3)
      ..write(obj.lpTokenInUserBalance)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexPoolHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
