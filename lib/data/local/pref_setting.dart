import 'package:shared_preferences/shared_preferences.dart';

class PrefSetting {
  static const String settingReminderPref = 'settingReminderPref';

  Future getReminder() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(settingReminderPref) ?? false;
  }

  void saveReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool(settingReminderPref, value);
  }
}