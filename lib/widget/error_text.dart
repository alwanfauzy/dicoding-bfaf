import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';

class ErrorText extends StatelessWidget {
  final String errorMessage;

  const ErrorText({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(errorMessage.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.merge(textWhite)),
      ),
    );
  }
}
