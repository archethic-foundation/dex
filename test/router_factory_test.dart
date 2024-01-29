library test.pool_factory_test;

// Project imports:
import 'package:aedex/application/router_factory.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Router Factory',
    () {
      test('getPoolList', () async {
        final routerFactory = RouterFactory(
          '00004910da0cd96b847006960b14b48735cd9e31aca02da3d323f2dd3c516eee5ab4',
          ApiService('http://127.0.0.1:4000'),
        );

        final result = await routerFactory.getPoolList();
        result.map(
          success: (success) {
            expect(
              success[0].pair.token1.address,
              '000044CD09615DA74933B099FF8FF8CB9CB1423FCD3E86188011457B8B7D2345EC67',
            );
            return;
          },
          failure: (failure) => throw failure,
        );
      });
    },
  );
}
