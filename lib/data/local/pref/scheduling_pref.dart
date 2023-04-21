import 'package:shared_preferences/shared_preferences.dart';

class SchedulingPref {
  static const SCHEDULING_STATUS = "scheduling_status";

  setScheduling(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SCHEDULING_STATUS, value);
  }

  Future<bool> getScheduling() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SCHEDULING_STATUS) ?? false;
  }
}
