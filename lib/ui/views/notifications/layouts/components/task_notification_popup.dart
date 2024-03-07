part of '../tasks_notification_widget.dart';

@freezed
class TaskNotificationPopup with _$TaskNotificationPopup {
  const factory TaskNotificationPopup({
    Key? key,
    required Widget icon,
    Widget? title,
    required Widget description,
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
    return TaskNotificationPopup.success(
      key: Key(task.id),
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
            'Final amount swapped: ${task.data.amount} ${task.data.dexToken.symbol}',
          ),
        ],
      ),
    );
  }

  factory TaskNotificationPopup._fromAddLiquidity(
    Task task,
  ) {
    if (task.failure != null) {
      return TaskNotificationPopup.failure(
        key: Key(task.id),
        description:
            SelectableText('Add liquidity ${task.data.txAddress} failed'),
      );
    }
    return TaskNotificationPopup.success(
      key: Key(task.id),
      description: SelectableText(
        'Liquidity added ${task.data.amount} on ${task.data.txAddress}',
      ),
    );
  }

  factory TaskNotificationPopup._fromRemoveLiquidity(
    Task task,
  ) {
    if (task.failure != null) {
      return TaskNotificationPopup.failure(
        key: Key(task.id),
        description:
            SelectableText('Remove liquidity ${task.data.txAddress} failed'),
      );
    }
    return TaskNotificationPopup.success(
      key: Key(task.id),
      description: SelectableText(
        'Liquidity removed ${task.data.amount} on ${task.data.txAddress}',
      ),
    );
  }
  const TaskNotificationPopup._();

  factory TaskNotificationPopup.success({
    Key? key,
    Widget? title,
    required Widget description,
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
        action: action,
        onActionPressed: onActionPressed,
      );

  factory TaskNotificationPopup.failure({
    Key? key,
    Widget? title,
    required Widget description,
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
          TaskNotificationPopup._fromAddLiquidity(task),
        DexActionType.removeLiquidity =>
          TaskNotificationPopup._fromRemoveLiquidity(task),
      };

  void show(BuildContext context) {
    ElegantNotification(
      key: key,
      icon: icon,
      background: Theme.of(context).colorScheme.background,
      description: description,
      title: title,
      showProgressIndicator: false,
      autoDismiss: false,
      action: action,
      onActionPressed: onActionPressed,
      enableShadow: false,
      width: 450,
      height: 80,
    ).show(context);
  }
}
