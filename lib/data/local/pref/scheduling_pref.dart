import 'package:shared_preferences/shared_preferences.dart';

class SchedulingPref {
  static const schedulingStatus = "scheduling_status";

  setScheduling(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(schedulingStatus, value);
  }

  Future<bool> getScheduling() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(schedulingStatus) ?? false;
  }
}
