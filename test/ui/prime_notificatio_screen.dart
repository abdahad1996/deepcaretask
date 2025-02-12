import 'package:deepcaretask/ui/screen/prime_notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'PrimeNotificationScreen displays correct prime number and elapsed time',
      (WidgetTester tester) async {
    // Arrange
    const int testPrimeNumber = 17;
    const Duration testElapsedTime = Duration(seconds: 42);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PrimeNotificationScreen(
            primeNumber: testPrimeNumber,
            elapsedTime: testElapsedTime,
          ),
        ),
      ),
    );

    
    expect(find.text("Congrats!"), findsOneWidget);
    expect(
        find.text("You obtained a prime number, it was: 17"), findsOneWidget);
    expect(find.text("Time since last prime number: 42 sec"), findsOneWidget);
    expect(find.text("Close"), findsOneWidget);
  });

  testWidgets('Tapping Close button dismisses the dialog',
      (WidgetTester tester) async {
    
    const int testPrimeNumber = 7;
    const Duration testElapsedTime = Duration(seconds: 30);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const PrimeNotificationScreen(
                    primeNumber: testPrimeNumber,
                    elapsedTime: testElapsedTime,
                  ),
                );
              },
              child: const Text("Show Dialog"),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text("Show Dialog"));
    await tester.pumpAndSettle();

    expect(find.byType(PrimeNotificationScreen), findsOneWidget);

    await tester.tap(find.text("Close"));
    await tester.pumpAndSettle();

    expect(find.byType(PrimeNotificationScreen), findsNothing);
  });
}
