import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationIndex { swap, pool, farm, earn, bridge }

final navigationIndexMainScreenProvider =
    StateProvider.autoDispose<NavigationIndex>((ref) => NavigationIndex.swap);
