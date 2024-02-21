/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aedex/domain/models/dex_notification.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification.g.dart';

@Riverpod(keepAlive: true)
class _NotificationNotifier extends Notifier<List<DexNotification>> {
  Timer? _timer;

  @override
  List<DexNotification> build() {
    ref.onDispose(() {
      if (_timer != null) {
        _timer!.cancel();
      }
    });
    return <DexNotification>[];
  }

  Future<void> addTransaction(
    final VoidCallback timerFunction,
  ) async {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      timerFunction();
    });
    return;
  }
}

abstract class NotificationProviders {
  static final notification = _notificationNotifierProvider;
}
