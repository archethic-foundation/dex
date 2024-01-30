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
      details: fields[4] as DexPoolInfosHive?,
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
      ..writeByte(4)
      ..write(obj.details);
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

class DexPoolInfosHiveAdapter extends TypeAdapter<DexPoolInfosHive> {
  @override
  final int typeId = 6;

  @override
  DexPoolInfosHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DexPoolInfosHive(
      fees: fields[1] as double,
      protocolFees: fields[9] as double,
      ratioToken1Token2: fields[2] as double,
      ratioToken2Token1: fields[3] as double,
      token1TotalFee: fields[4] as double?,
      token1TotalVolume: fields[5] as double?,
      token2TotalFee: fields[6] as double?,
      token2TotalVolume: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DexPoolInfosHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.fees)
      ..writeByte(2)
      ..write(obj.ratioToken1Token2)
      ..writeByte(3)
      ..write(obj.ratioToken2Token1)
      ..writeByte(4)
      ..write(obj.token1TotalFee)
      ..writeByte(5)
      ..write(obj.token1TotalVolume)
      ..writeByte(6)
      ..write(obj.token2TotalFee)
      ..writeByte(7)
      ..write(obj.token2TotalVolume)
      ..writeByte(9)
      ..write(obj.protocolFees);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DexPoolInfosHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
