import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/scheduling_provider.dart';
import '../common/styles.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/settings";

  const SettingsPage({super.key});

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
      child: _buildOptions(context),
    );
  }

  Widget _buildOption(BuildContext context, String title, Widget trailing) {
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

  Widget _buildOptions(BuildContext context) {
    return ListView(
      children: [
        _buildOption(
          context,
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
