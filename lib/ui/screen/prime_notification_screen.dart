import 'package:deepcaretask/ui/app_theme.dart';
import 'package:deepcaretask/ui/views/divide_bar.dart';
import 'package:deepcaretask/ui/views/notification_text.dart';
import 'package:flutter/material.dart';

class PrimeNotificationScreen extends StatelessWidget {
  final int primeNumber;
  final Duration elapsedTime;

  const PrimeNotificationScreen({
    super.key,
    required this.primeNumber,
    required this.elapsedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const DividerBar(),
            const SizedBox(height: 20),
            const NotificationText(
              text: "Congrats!",
              style: AppTheme.titleTextStyle,
            ),
            const SizedBox(height: 10),
            NotificationText(
              text: "You obtained a prime number, it was: $primeNumber",
              style: AppTheme.subtitleTextStyle,
            ),
            const SizedBox(height: 10),
            NotificationText(
              text:
                  "Time since last prime number: ${elapsedTime.inSeconds} sec",
              style: AppTheme.infoTextStyle,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: AppTheme.buttonStyle,
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
