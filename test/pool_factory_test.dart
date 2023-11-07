library test.pool_factory_test;

// Project imports:
import 'package:aedex/application/pool_factory.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Pool Factory',
    () {
      test('getPairTokens', () async {
        final poolFactory = PoolFactory(
          '0000a1cc1d32b9ab8ea1e14d187e5b2367b0873afd6942a2aa56466af15fb14358d3',
          ApiService('http://127.0.0.1:4000'),
        );

        var token1Address = '';
        var token2Address = '';
        final result = await poolFactory.getPairTokens();
        result.map(
          success: (dexPair) {
            token1Address = dexPair.token1.address!;
            token2Address = dexPair.token2.address!;

            return;
          },
          failure: (failure) => throw failure,
        );

        expect(
          token1Address,
          '000044CD09615DA74933B099FF8FF8CB9CB1423FCD3E86188011457B8B7D2345EC67',
        );
        expect(
          token2Address,
          '00008E35CBDCEA568BA0524B8F95578054482CA1A5DBD03E3EE893E7416C377FDDA1',
        );
      });
    },
  );
}
