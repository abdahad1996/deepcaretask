import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:deepcaretask/presentation/random_number_bloc.dart';
import 'package:deepcaretask/presentation/random_number_event.dart';
import 'package:deepcaretask/presentation/random_number_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stub_fetch_random_number_usecase.dart';

void main() {
  late RandomNumberBloc bloc;
  late StubFetchRandomNumberUseCase stubUseCase;
  late SharedPreferences prefs;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  group('RandomNumberBloc Tests', () {
    setUp(() {
     stubUseCase = StubFetchRandomNumberUseCase(numberToReturn: 7, shouldFail: false);
      bloc = RandomNumberBloc(stubUseCase, prefs);
    });

    tearDown(() async {
      await bloc.close();
    });

    test('initial state is RandomNumberInitial', () {
      expect(bloc.state, isA<RandomNumberInitial>());
    });

    blocTest<RandomNumberBloc, RandomNumberState>(
      'emits RandomNumberLoaded when FetchRandomNumberEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(FetchRandomNumberEvent()),
      expect: () => [
        RandomNumberLoaded(number: 7),
        PrimeNumberDetected(primeNumber: 7, elapsedTime: Duration.zero),
      ],
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'does not emit PrimeNumberDetected if fetched number is not prime',
      setUp: () {
        stubUseCase =
            StubFetchRandomNumberUseCase(numberToReturn: 10, shouldFail: false);
        bloc = RandomNumberBloc(stubUseCase, prefs);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchRandomNumberEvent()),
      expect: () => [
        RandomNumberLoaded(number: 10),
      ],
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'emits PrimeNumberDetected with elapsed time of ~30 seconds',
      setUp: () async {
        stubUseCase = StubFetchRandomNumberUseCase(numberToReturn: 7, shouldFail: false);
        bloc = RandomNumberBloc(stubUseCase, prefs);
        final thirtySecondsAgo = DateTime.now().subtract(Duration(seconds: 30));
        await prefs.setInt(
            'last_prime_timestamp', thirtySecondsAgo.millisecondsSinceEpoch);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchRandomNumberEvent()),
      verify: (bloc) {
        final state = bloc.state as PrimeNumberDetected;
        expect(state.primeNumber, 7);
        expect(state.elapsedTime.inSeconds, closeTo(30, 1));
      },
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'emits PrimeNumberDetected with zero elapsed time when no previous prime',
      build: () => bloc,
      act: (bloc) => bloc.add(FetchRandomNumberEvent()),
      expect: () => [
        RandomNumberLoaded(number: 7),
        PrimeNumberDetected(primeNumber: 7, elapsedTime: Duration.zero),
      ],
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'handles error when fetching fails',
      setUp: () {
        stubUseCase = StubFetchRandomNumberUseCase(shouldFail: true, numberToReturn: 7);
        bloc = RandomNumberBloc(stubUseCase, prefs);
      },
      build: () => bloc,
      act: (bloc) => bloc.add(FetchRandomNumberEvent()),
      expect: () => [
        RandomNumberError(message: 'Failed to fetch random number'),
      ],
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'updates clock every second',
      build: () => bloc,
      act: (bloc) => bloc.add(ClockUpdateEvent()),
      expect: () => [
        isA<ClockUpdated>(),
      ],
    );

    blocTest<RandomNumberBloc, RandomNumberState>(
      'cancels timers when closed',
      build: () => bloc,
      act: (bloc) async {
        await bloc.close();
      },
      verify: (bloc) {
        expect(bloc.state, isA<RandomNumberInitial>());
      },
    );
  });
}
