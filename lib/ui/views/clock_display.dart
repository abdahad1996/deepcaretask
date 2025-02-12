import 'package:deepcaretask/ui/app_theme.dart';
import 'package:flutter/material.dart';

class ClockDisplay extends StatelessWidget {
  final String time;
  final String date;

  const ClockDisplay({
    super.key,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(time, style: AppTheme.clockTextStyle),
        const SizedBox(height: 10),
        Text(date, style: AppTheme.dateTextStyle),
      ],
    );
  }
}
