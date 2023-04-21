import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:resto_app/data/local/pref/scheduling_pref.dart';
import 'package:resto_app/util/background_service.dart';
import 'package:resto_app/util/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  SchedulingPref schedulingPref = SchedulingPref();
  bool _scheduling = false;

  bool get scheduling => _scheduling;

  Future<bool> setScheduling(bool value) async {
    _scheduling = value;
    schedulingPref.setScheduling(value);
    notifyListeners();

    if (_scheduling) {
      if (kDebugMode) {
        print('Scheduling Restaurant Activated');
      }
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Restaurant Canceled');
      }
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
