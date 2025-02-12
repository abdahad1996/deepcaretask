import 'package:deepcaretask/ui/app_theme.dart';
import 'package:deepcaretask/ui/screen/prime_notification_screen.dart';
import 'package:deepcaretask/ui/views/clock_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/random_number_bloc.dart';
import '../../presentation/random_number_state.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text("Live Clock & Prime Checker"),
        backgroundColor: AppTheme.backgroundColor,
        foregroundColor: AppTheme.textColor,
      ),
      body: PrimeNumberListener(
        child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
          buildWhen: (previous, current) => current is ClockUpdated,
          builder: (context, state) {
            final time = state is ClockUpdated ? state.time : "00:00";
            final date = state is ClockUpdated ? state.date : "Loading...";

            return Center(child: ClockDisplay(time: time, date: date));
          },
        ),
      ),
    );
  }
}


class PrimeNumberListener extends StatelessWidget {
  final Widget child;

  const PrimeNumberListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RandomNumberBloc, RandomNumberState>(
      listener: (context, state) {
        if (state is PrimeNumberDetected) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PrimeNotificationScreen(
                primeNumber: state.primeNumber,
                elapsedTime: state.elapsedTime,
              ),
            ),
          );
        }
      },
      child: child,
    );
  }
}