import 'package:deepcaretask/ui/app_theme.dart';
import 'package:flutter/material.dart';

class DividerBar extends StatelessWidget {
  const DividerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
