part of '../tasks_notification_widget.dart';

class RunningTasksNotificationWidget extends ConsumerWidget {
  const RunningTasksNotificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runningTasksCount = ref.watch(
      NotificationProviders.runningTasks
          .select((value) => value.valueOrNull?.length ?? 0),
    );

    if (runningTasksCount == 0) return const SizedBox();
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElegantNotification(
            icon: const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox.square(
                dimension: 23,
                child: CircularProgressIndicator(),
              ),
            ),
            background: Theme.of(context).colorScheme.background,
            description: Text('$runningTasksCount Pending'),
            showProgressIndicator: false,
            autoDismiss: false,
            displayCloseButton: false,
            width: 200,
            height: 50,
          ),
        ),
      ),
    );
    //   ,
  }
}
