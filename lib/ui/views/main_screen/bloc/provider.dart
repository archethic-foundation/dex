import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationIndex { swap, pool, farm }

final navigationIndexMainScreenProvider =
    StateProvider.autoDispose<NavigationIndex>((ref) => NavigationIndex.swap);
