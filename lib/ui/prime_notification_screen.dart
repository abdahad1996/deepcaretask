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
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Congrats!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You obtained a prime number, it was: $primeNumber",
              style: const TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Time since last prime number: ${elapsedTime.inSeconds} sec",
              style: const TextStyle(color: Colors.white54, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 237, 127),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
