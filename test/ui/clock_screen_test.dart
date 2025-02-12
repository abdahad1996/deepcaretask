import 'package:deepcaretask/presentation/random_number_bloc.dart';
import 'package:deepcaretask/presentation/random_number_event.dart';
import 'package:deepcaretask/presentation/random_number_state.dart';
import 'package:deepcaretask/ui/screen/clock_screen.dart';
import 'package:deepcaretask/ui/screen/prime_notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockRandomNumberBloc
    extends MockBloc<RandomNumberEvent, RandomNumberState>
    implements RandomNumberBloc {}

void main() {
  late MockRandomNumberBloc mockBloc;

  setUp(() {
    mockBloc = MockRandomNumberBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<RandomNumberBloc>.value(
        value: mockBloc,
        child: const ClockScreen(),
      ),
    );
  }

  testWidgets('Initial state shows default clock values',
      (WidgetTester tester) async {
    whenListen(
      mockBloc,
      Stream<RandomNumberState>.empty(),
      initialState: RandomNumberInitial(),
    );

    await tester.pumpWidget(createTestWidget());

    expect(find.text('00:00'), findsOneWidget);
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('Clock updates when ClockUpdated state is emitted',
      (WidgetTester tester) async {
    whenListen(
      mockBloc,
      Stream<RandomNumberState>.fromIterable([
        ClockUpdated(time: '12:30', date: 'Feb 12, 2025'),
      ]),
      initialState: RandomNumberInitial(),
    );

    await tester.pumpWidget(createTestWidget());
    await tester.pump();  

    expect(find.text('12:30'), findsOneWidget);
    expect(find.text('Feb 12, 2025'), findsOneWidget);
  });

  testWidgets('Navigates to PrimeNotificationScreen on PrimeNumberDetected',
      (WidgetTester tester) async {
    whenListen(
      mockBloc,
      Stream<RandomNumberState>.fromIterable([
        PrimeNumberDetected(primeNumber: 7, elapsedTime: Duration(seconds: 30)),
      ]),
      initialState: RandomNumberInitial(),
    );

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();    
    expect(find.byType(PrimeNotificationScreen), findsOneWidget);
  });
}
