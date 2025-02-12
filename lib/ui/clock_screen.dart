import 'package:deepcaretask/presentation/random_number_bloc.dart';
import 'package:deepcaretask/presentation/random_number_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'prime_notification_screen.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ensure clock is visible
      appBar: AppBar(
        title: const Text("Live Clock & Prime Checker"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<RandomNumberBloc, RandomNumberState>(
        listener: (context, state) {
          if (state is PrimeNumberDetected) {
            // Close any existing PrimeNotificationScreen before opening a new one
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
        buildWhen: (previous, current) => current is ClockUpdated,
        builder: (context, state) {
        final time = state is ClockUpdated ? state.time : "00:00";
        final date = state is ClockUpdated ? state.date : "Loading...";

          return Center(
            // Ensure proper alignment
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                    ,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
