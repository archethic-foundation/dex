import 'package:aedex/domain/models/dex_token.dart';
import 'package:aedex/infrastructure/hive/db_helper.hive.dart';
import 'package:hive/hive.dart';

part 'dex_token.hive.g.dart';

@HiveType(typeId: HiveTypeIds.dexToken)
class DexTokenHive extends HiveObject {
  DexTokenHive({
    required this.name,
    required this.address,
    required this.icon,
    required this.symbol,
    required this.balance,
    required this.reserve,
    required this.supply,
    required this.verified,
  });

  factory DexTokenHive.fromModel(DexToken dexToken) {
    return DexTokenHive(
      name: dexToken.name,
      address: dexToken.address,
      icon: dexToken.icon,
      symbol: dexToken.symbol,
      balance: dexToken.balance,
      reserve: dexToken.reserve,
      supply: dexToken.supply,
      verified: dexToken.verified,
    );
  }
  @HiveField(0)
  String name;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? icon;

  @HiveField(3)
  String symbol;

  @HiveField(4)
  double balance;

  @HiveField(5)
  double reserve;

  @HiveField(6)
  double supply;

  @HiveField(7)
  bool verified;

  DexToken toModel() {
    return DexToken(
      name: name,
      address: address,
      icon: icon,
      symbol: symbol,
      balance: balance,
      reserve: reserve,
      supply: supply,
      verified: verified,
    );
  }
}
