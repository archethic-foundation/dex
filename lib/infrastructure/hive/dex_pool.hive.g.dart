// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_pool.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DexPoolHiveAdapter extends TypeAdapter<DexPoolHive> {
  @override
  final int typeId = 3;

  @override
  DexPoolHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPoolHive(
      poolAddress: fields[0] as String,
      lpToken: fields[1] as DexTokenHive?,
      ranking: fields[2] as int,
      pair: fields[3] as DexPairHive?,
      fees: fields[4] as double,
      ratioToken1Token2: fields[5] as double,
      ratioToken2Token1: fields[6] as double,
      estimatePoolTVLInFiat: fields[7] as double,
      lpTokenInUserBalance: fields[8] as bool,
      token1TotalFee: fields[9] as double?,
      token1TotalVolume: fields[10] as double?,
      token2TotalFee: fields[11] as double?,
      token2TotalVolume: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DexPoolHive obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.poolAddress)
      ..writeByte(1)
      ..write(obj.lpToken)
      ..writeByte(2)
      ..write(obj.ranking)
      ..writeByte(3)
      ..write(obj.pair)
      ..writeByte(4)
      ..write(obj.fees)
      ..writeByte(5)
      ..write(obj.ratioToken1Token2)
      ..writeByte(6)
      ..write(obj.ratioToken2Token1)
      ..writeByte(7)
      ..write(obj.estimatePoolTVLInFiat)
      ..writeByte(8)
      ..write(obj.lpTokenInUserBalance)
      ..writeByte(9)
      ..write(obj.token1TotalFee)
      ..writeByte(10)
      ..write(obj.token1TotalVolume)
      ..writeByte(11)
      ..write(obj.token2TotalFee)
      ..writeByte(12)
      ..write(obj.token2TotalVolume);
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
