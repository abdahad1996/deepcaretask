import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/fetch_random_number_usecase.dart';
import 'random_number_event.dart';
import 'random_number_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'date_helper.dart'; // Import for date formatting extensions

/// Bloc to handle random number fetching, prime number detection, and live clock updates
class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  final FetchRandomNumberUseCase _fetchRandomNumberUseCase;
  final SharedPreferences _prefs;
  Timer? _timer; // Timer for periodic number fetching
  static const String _key =
      "last_prime_timestamp"; // Key for storing last prime number timestamp

  /// Constructor initializes Bloc, listens to events, and starts periodic tasks
  RandomNumberBloc(this._fetchRandomNumberUseCase, this._prefs)
      : super(RandomNumberInitial()) {
    // Register event handlers
    on<FetchRandomNumberEvent>(_onFetchRandomNumber);
    on<PrimeNumberFoundEvent>(_onPrimeNumberFound);
    on<ClockUpdateEvent>(_onClockUpdate); // Handles real-time clock updates

    _startFetching(); // Starts periodic random number fetching
    _startClockUpdates(); // Starts clock updates every second
  }

  /// 🔄 Starts periodic fetching of random numbers every 10 seconds
  void _startFetching() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      add(FetchRandomNumberEvent()); // Dispatch event to fetch number
    });
  }


/// 🕰️ Generates a stream that updates the clock in real-time
  Stream<DateTime> _clockStream() =>
      Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  /// Start listening to the stream and emit updated clock state
  void _startClockUpdates() {
    _clockStream().listen((now) {
      add(ClockUpdateEvent()); // Dispatch event every second
    });
  }
  /// 📥 Handles fetching a random number and checking if it's prime
  Future<void> _onFetchRandomNumber(
    FetchRandomNumberEvent event,
    Emitter<RandomNumberState> emit,
  ) async {
    try {
      // Fetch a new random number
      final randomNumber = await _fetchRandomNumberUseCase.loadNumber();
      emit(RandomNumberLoaded(
          number: randomNumber.value)); // Emit state with number

      // Check if the fetched number is prime
      if (randomNumber.isPrime()) {

        // Retrieve the last recorded prime number timestamp
        final lastTime = await _getLastPrimeTime();
        final elapsedTime = lastTime != null
            ? DateTime.now()
                .difference(lastTime) // Calculate time since last prime
            : Duration.zero;

        // Store the current prime number timestamp
        await _storeLastPrimeTime(DateTime.now());

        // Dispatch event indicating a prime number was found
        add(PrimeNumberFoundEvent(
            primeNumber: randomNumber.value, elapsedTime: elapsedTime));
      }
    } catch (e) {
      emit(RandomNumberError(message: 'Failed to fetch random number'));
    }
  }

  /// 🎯 Handles detected prime numbers and emits a state with the prime info
  void _onPrimeNumberFound(
    PrimeNumberFoundEvent event,
    Emitter<RandomNumberState> emit,
  ) {
    emit(PrimeNumberDetected(
        primeNumber: event.primeNumber, elapsedTime: event.elapsedTime));
  }

  /// 🕒 Handles clock updates by formatting the current time and date
  void _onClockUpdate(ClockUpdateEvent event, Emitter<RandomNumberState> emit) {
    final now = DateTime.now(); // Get current time
    emit(ClockUpdated(
        time: now.toFormattedTime(),
        date: now.toFormattedDate())); // Emit formatted time
  }

  

  /// 🏛 Retrieves the timestamp of the last detected prime number
  Future<DateTime?> _getLastPrimeTime() async {
    final timestamp = _prefs.getInt(_key);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  /// 📝 Stores the timestamp of the latest detected prime number
  Future<void> _storeLastPrimeTime(DateTime timestamp) async {
    await _prefs.setInt(_key, timestamp.millisecondsSinceEpoch);
  }

  /// 🛑 Cancels timers when the Bloc is closed to prevent memory leaks
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
