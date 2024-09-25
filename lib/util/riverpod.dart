import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefListenSelectExtension<State extends Object?, T> on Ref<State> {
  void invalidateSelfOnPropertyChange(
    T? Function(State? state) select,
  ) {
    listenSelf((previous, next) {
      final previousValue = select(previous);
      final nextValue = select(next);

      if (previousValue == nextValue) return;
      invalidateSelf();
    });
  }
}
