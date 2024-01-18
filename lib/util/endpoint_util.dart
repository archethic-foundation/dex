import 'package:aedex/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class EndpointUtil {
  static String getEnvironnement() {
    final endpointUrl = sl.get<ApiService>().endpoint;
    switch (endpointUrl) {
      case 'https://testnet.archethic.net':
        return 'testnet';
      case 'https://mainnet.archethic.net':
        return 'mainnet';
      default:
        return 'devnet';
    }
  }

  static String getEnvironnementUrl(String env) {
    switch (env) {
      case 'testnet':
        return 'https://testnet.archethic.net';
      case 'mainnet':
        return 'https://mainnet.archethic.net';
      default:
        return 'http://localhost:4000';
    }
  }

  static String getEnvironnementLabel(String endpoint) {
    switch (endpoint) {
      case 'https://testnet.archethic.net':
        return 'Archethic Testnet';
      case 'https://mainnet.archethic.net':
        return 'Archethic Mainnet';
      case '':
        return 'No environment';
      default:
        return 'Archethic Devnet';
    }
  }
}
