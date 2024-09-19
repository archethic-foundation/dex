import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationIndex { swap, pool, earn, bridge, getWallet, welcome }

final navigationIndexMainScreenProvider =
    StateProvider.autoDispose<NavigationIndex>(
        (ref) => NavigationIndex.welcome);
