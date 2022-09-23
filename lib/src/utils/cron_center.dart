import 'package:cron/cron.dart';

class CronCenter {
  final cron = Cron();
  final List<ScheduledTask> tasks = [];

  Future<void> addCronTasks(
      String expression, void Function() onTaskTime) async {
    final task = cron.schedule(Schedule.parse(expression), () async {
      onTaskTime();
    });
    tasks.add(task);
  }

  void deleteAllCronTasks() {
    for (var task in tasks) {
      task.cancel();
    }
    tasks.clear();
    return;
  }
}
