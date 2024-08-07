part of '../tasks_notification_widget.dart';

@freezed
class TaskNotificationPopup with _$TaskNotificationPopup {
  const factory TaskNotificationPopup({
    Key? key,
    required Widget icon,
    Widget? title,
    required Widget description,
    required DexActionType actionType,
    Widget? action,
    VoidCallback? onActionPressed,
    required Color progressIndicatorColor,
  }) = _TaskNotificationPopup;

  factory TaskNotificationPopup._fromSwap(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        AppLocalizations.of(context)!.swapInProgressTxAddresses,
        task,
        context,
      );
    }
    final amount = task.data.amountSwapped as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.swapInProgressTxAddresses} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.swapFinalAmountAmountSwapped} ${amount.formatNumber(precision: 8)} ${task.data.tokenSwapped.symbol}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromAddLiquidity(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.liquidityAddInProgresstxAddressesShort} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.liquidityAddInProgresstxAddressesShort} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.liquidityAddFinalAmount} ${amount.formatNumber(precision: 8)} ${task.data.amount! > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromRemoveLiquidity(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.liquidityRemoveInProgressTxAddressesShort} ',
        task,
        context,
      );
    }
    final amountToken1 = task.data.amountToken1 as double;
    final amountToken2 = task.data.amountToken2 as double;
    final amountLPToken = task.data.amountLPToken as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.liquidityRemoveInProgressTxAddressesShort} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ${amountToken1.formatNumber(precision: 8)} ${task.data.token1!.symbol}',
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenObtained} ${amountToken2.formatNumber(precision: 8)} ${task.data.token2!.symbol}',
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.liquidityRemoveFinalAmountTokenBurned} ${amountLPToken.formatNumber(precision: 8)} ${amountLPToken > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromClaimFarm(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmClaimTxAddress} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header: '${AppLocalizations.of(context)!.farmClaimTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmClaimFinalAmount} ${amount.formatNumber(precision: 8)} ${task.data.rewardToken.symbol}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromClaimFarmLock(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmLockClaimTxAddress} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header: '${AppLocalizations.of(context)!.farmLockClaimTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockClaimFinalAmount} ${amount.formatNumber(precision: 8)} ${task.data.rewardToken.symbol}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromDepositFarm(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmDepositTxAddress} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header: '${AppLocalizations.of(context)!.farmDepositTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmDepositFinalAmount} ${amount.formatNumber(precision: 8)} ${amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromDepositFarmLock(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmLockDepositTxAddress} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.farmLockDepositTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockDepositFinalAmount} ${amount.formatNumber(precision: 8)} ${amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromLevelUpFarmLock(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmLockLevelUpTxAddress} ',
        task,
        context,
      );
    }
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.farmLockLevelUpTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockLevelUpFinalAmount} ${amount.formatNumber(precision: 8)} ${amount > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromWithdrawFarm(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmWithdrawTxAddress} ',
        task,
        context,
      );
    }
    final amountReward = task.data.amountReward as double;
    final amountWithdraw = task.data.amountWithdraw as double;
    final isFarmClose = task.data.isFarmClose as bool;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header: '${AppLocalizations.of(context)!.farmWithdrawTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmWithdrawFinalAmount} ${amountWithdraw.formatNumber(precision: 8)} ${amountWithdraw > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
          if ((isFarmClose == true && amountReward > 0) || isFarmClose == false)
            SelectableText(
              '${AppLocalizations.of(context)!.farmWithdrawFinalAmountReward} ${amountReward.formatNumber(precision: 8)} ${task.data.rewardToken!.symbol}',
            ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromWithdrawFarmLock(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
      return _getErrorNotification(
        '${AppLocalizations.of(context)!.farmLockWithdrawTxAddress} ',
        task,
        context,
      );
    }
    final amountReward = task.data.amountReward as double;
    final amountWithdraw = task.data.amountWithdraw as double;
    final isFarmClose = task.data.isFarmClose as bool;
    return TaskNotificationPopup.success(
      key: Key(task.id),
      actionType: task.data.actionType,
      description: Wrap(
        direction: Axis.vertical,
        children: [
          if (task.dateTask != null)
            SelectableText(
              DateFormat.yMd(
                Localizations.localeOf(context).languageCode,
              ).add_Hms().format(
                    task.dateTask!.toLocal(),
                  ),
            ),
          addresslinkcopy.FormatAddressLinkCopy(
            address: task.data.txAddress.toUpperCase(),
            header:
                '${AppLocalizations.of(context)!.farmLockWithdrawTxAddress} ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmount} ${amountWithdraw.formatNumber(precision: 8)} ${amountWithdraw > 1 ? AppLocalizations.of(context)!.lpTokens : AppLocalizations.of(context)!.lpToken}',
          ),
          if ((isFarmClose == true && amountReward > 0) || isFarmClose == false)
            SelectableText(
              '${AppLocalizations.of(context)!.farmLockWithdrawFinalAmountReward} ${amountReward.formatNumber(precision: 8)} ${task.data.rewardToken!.symbol}',
            ),
        ],
      ),
    );
  }

  const TaskNotificationPopup._();

  factory TaskNotificationPopup.success({
    Key? key,
    Widget? title,
    required Widget description,
    required DexActionType actionType,
    Widget? action,
    VoidCallback? onActionPressed,
  }) =>
      TaskNotificationPopup(
        key: key,
        icon: const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        ),
        title: title,
        description: description,
        actionType: actionType,
        action: action,
        onActionPressed: onActionPressed,
        progressIndicatorColor: Colors.green,
      );

  factory TaskNotificationPopup.failure({
    Key? key,
    Widget? title,
    required Widget description,
    required DexActionType actionType,
    Widget? action,
    VoidCallback? onActionPressed,
  }) =>
      TaskNotificationPopup(
        key: key,
        icon: const Icon(
          Icons.error_outline_outlined,
          color: Colors.red,
        ),
        title: title,
        description: description,
        actionType: actionType,
        action: action,
        onActionPressed: onActionPressed,
        progressIndicatorColor: Colors.red,
      );

  factory TaskNotificationPopup.fromTask(
    Task<DexNotification, aedappfm.Failure> task,
    BuildContext context,
  ) =>
      switch (task.data.actionType) {
        DexActionType.swap => TaskNotificationPopup._fromSwap(task, context),
        DexActionType.addLiquidity =>
          TaskNotificationPopup._fromAddLiquidity(task, context),
        DexActionType.removeLiquidity =>
          TaskNotificationPopup._fromRemoveLiquidity(task, context),
        DexActionType.claimFarm =>
          TaskNotificationPopup._fromClaimFarm(task, context),
        DexActionType.claimFarmLock =>
          TaskNotificationPopup._fromClaimFarmLock(task, context),
        DexActionType.depositFarm =>
          TaskNotificationPopup._fromDepositFarm(task, context),
        DexActionType.depositFarmLock =>
          TaskNotificationPopup._fromDepositFarmLock(task, context),
        DexActionType.levelUpFarmLock =>
          TaskNotificationPopup._fromLevelUpFarmLock(task, context),
        DexActionType.withdrawFarm =>
          TaskNotificationPopup._fromWithdrawFarm(task, context),
        DexActionType.withdrawFarmLock =>
          TaskNotificationPopup._fromWithdrawFarmLock(task, context),
        DexActionType.addPool =>
          TaskNotificationPopup._fromRemoveLiquidity(task, context),
      };

  void show(BuildContext context) {
    double? width;
    if (aedappfm.Responsive.isMobile(context)) {
      width = MediaQuery.of(context).size.width * 0.90;
    } else {
      if (aedappfm.Responsive.isTablet(context)) {
        width = MediaQuery.of(context).size.width / 2;
      } else {
        width = MediaQuery.of(context).size.width / 3;
      }
    }

    double? height;
    switch (actionType) {
      case DexActionType.swap:
        height = 80;
        break;
      case DexActionType.addLiquidity:
        height = 80;
        break;
      case DexActionType.removeLiquidity:
        height = 160;
        break;
      case DexActionType.claimFarm:
        height = 80;
        break;
      case DexActionType.claimFarmLock:
        height = 80;
        break;
      case DexActionType.depositFarm:
        height = 80;
        break;
      case DexActionType.depositFarmLock:
        height = 80;
        break;
      case DexActionType.levelUpFarmLock:
        height = 80;
        break;
      case DexActionType.withdrawFarm:
        height = 120;
        break;
      case DexActionType.withdrawFarmLock:
        height = 120;
        break;
      case DexActionType.addPool:
        height = 80;
        break;
    }

    ElegantNotification(
      key: key,
      icon: icon,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      background: Theme.of(context).colorScheme.surface,
      description: description,
      title: title,
      toastDuration: const Duration(seconds: 20),
      progressIndicatorColor: progressIndicatorColor,
      action: action,
      onNotificationPressed: onActionPressed,
      width: width,
      height: height,
    ).show(context);
  }
}

TaskNotificationPopup _getErrorNotification(
  String header,
  Task task,
  BuildContext context,
) {
  return TaskNotificationPopup.failure(
    key: Key(task.id),
    actionType: task.data.actionType,
    description: Wrap(
      children: [
        if (task.dateTask != null)
          SelectableText(
            DateFormat.yMd(
              Localizations.localeOf(context).languageCode,
            ).add_Hms().format(
                  task.dateTask!.toLocal(),
                ),
          ),
        addresslinkcopy.FormatAddressLinkCopy(
          address: task.data.txAddress.toUpperCase(),
          header: header,
          typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
          reduceAddress: true,
        ),
        SelectableText(
          'Error: ${FailureMessage(context: context, failure: task.failure).getMessage()}',
        ),
      ],
    ),
  );
}
