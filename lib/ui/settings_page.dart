import 'package:flutter/material.dart';

import '../common/styles.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/settings";

  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _reminderIsActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _onReminderSwitchClicked() {
    setState(() {
      _reminderIsActive = !_reminderIsActive;
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
    return InkWell(
      splashColor: primaryColor,
      onTap: () => _onReminderSwitchClicked(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Daily Reminder",
              style:
                  Theme.of(context).textTheme.bodyMedium?.merge(textWhiteBold),
            ),
            Switch(
              activeColor: secondaryDarkColor,
              value: _reminderIsActive,
              onChanged: (value) => _onReminderSwitchClicked(),
            )
          ],
        ),
      ),
    );
  }
}
