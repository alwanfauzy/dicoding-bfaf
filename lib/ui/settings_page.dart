import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/local/pref_setting.dart';
import 'package:resto_app/provider/scheduling_provider.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/util/notification_helper.dart';
import '../common/styles.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/settings";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _reminderIsActive = false;
  var prefSetting = PrefSetting();

  @override
  void initState() {
    super.initState();
    _initReminder();
  }

  _initReminder() async {
    var value = await prefSetting.getReminder();
    setState(() {
      _reminderIsActive = value;
    });
  }

  _onReminderSwitchClicked() {
    setState(() {
      _reminderIsActive = !_reminderIsActive;
      prefSetting.saveReminder(_reminderIsActive);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: _buildOptions(),
    );
  }

  Widget _buildOption(String title, Widget trailing) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.merge(textWhiteBold),
        ),
        trailing: trailing,
      ),
    );
  }

  Widget _buildOptions() {
    return ListView(
      children: [
        _buildOption(
          "Dark Theme",
          Switch.adaptive(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
        _buildOption(
          "Scheduling Restaurant",
          Consumer<SchedulingProvider>(
            builder: (context, scheduled, _) {
              return Switch.adaptive(
                value: scheduled.isScheduled,
                onChanged: (value) async {
                  scheduled.scheduledRestaurant(value);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
