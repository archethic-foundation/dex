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
  }) = _TaskNotificationPopup;

  factory TaskNotificationPopup._fromSwap(
    Task task,
    BuildContext context,
  ) {
    if (task.failure != null) {
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
              header: 'Swap transaction address: ',
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
    final amount = task.data.amountSwapped as double;
    return TaskNotificationPopup.success(
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
            header: 'Swap transaction address: ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            'Final amount swapped: ${amount.formatNumber(precision: 8)} ${task.data.tokenSwapped.symbol}',
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
              header: 'Liquidity add. transaction address: ',
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
    final amount = task.data.amount as double;
    return TaskNotificationPopup.success(
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
            header: 'Liquidity add. transaction address: ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            'LP Tokens burned: ${amount.formatNumber(precision: 8)} ${task.data.amount! > 1 ? 'LP Tokens' : 'LP Token'}',
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
              header: 'Liquidity supp. transaction address: ',
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
    final amountToken1 = task.data.amountToken1 as double;
    final amountToken2 = task.data.amountToken2 as double;
    final amountLPToken = task.data.amountLPToken as double;
    return TaskNotificationPopup.success(
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
            header: 'Liquidity supp. transaction address: ',
            typeAddress: addresslinkcopy.TypeAddressLinkCopy.transaction,
            reduceAddress: true,
          ),
          SelectableText(
            'Token obtained: ${amountToken1.formatNumber(precision: 8)} ${task.data.token1!.symbol}',
          ),
          SelectableText(
            'Token obtained: ${amountToken2.formatNumber(precision: 8)} ${task.data.token2!.symbol}',
          ),
          SelectableText(
            'LP Token burned: ${amountLPToken.formatNumber(precision: 8)} ${amountLPToken > 1 ? 'LP Tokens' : 'LP Token'}',
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
      };

  void show(BuildContext context) {
    double? width;
    double? height;
    switch (actionType) {
      case DexActionType.swap:
        width = 450;
        height = 80;
        break;
      case DexActionType.addLiquidity:
        width = 500;
        height = 80;
        break;
      case DexActionType.removeLiquidity:
        width = 500;
        height = 160;
        break;
    }

    ElegantNotification(
      key: key,
      icon: icon,
      radius: 16,
      background: Theme.of(context).colorScheme.background,
      description: description,
      title: title,
      showProgressIndicator: false,
      autoDismiss: false,
      action: action,
      onActionPressed: onActionPressed,
      enableShadow: false,
      width: width,
      height: height,
    ).show(context);
  }
}
