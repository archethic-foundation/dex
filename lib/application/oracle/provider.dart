/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aedex/application/oracle/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _ArchethicOracleUCONotifier extends Notifier<ArchethicOracleUCO> {
  ArchethicOracle? archethicOracle;

  @override
  ArchethicOracleUCO build() {
    ref.onDispose(() {
      if (archethicOracle != null) {
        aedappfm.sl
            .get<OracleService>()
            .closeOracleUpdatesSubscription(archethicOracle!);
      }
    });
    return const ArchethicOracleUCO();
  }

  Future<void> init() async {
    await _getValue();
    await _subscribe();
  }

  Future<void> _getValue() async {
    final oracleUcoPrice =
        await aedappfm.sl.get<OracleService>().getOracleData();
    _fillInfo(oracleUcoPrice);
  }

  Future<void> _subscribe() async {
    archethicOracle = await aedappfm.sl
        .get<OracleService>()
        .subscribeToOracleUpdates((oracleUcoPrice) {
      _fillInfo(oracleUcoPrice!);
    });
  }

  void _fillInfo(OracleUcoPrice oracleUcoPrice) {
    state = state.copyWith(
      timestamp: oracleUcoPrice.timestamp ?? 0,
      eur: oracleUcoPrice.uco!.eur ?? 0,
      usd: oracleUcoPrice.uco!.usd ?? 0,
    );
  }
}

abstract class ArchethicOracleUCOProviders {
  static final archethicOracleUCO = _archethicOracleUCONotifierProvider;
}
