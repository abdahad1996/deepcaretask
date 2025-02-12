import 'package:equatable/equatable.dart';

abstract class RandomNumberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRandomNumberEvent extends RandomNumberEvent {}

class ClockUpdateEvent extends RandomNumberEvent {}

class PrimeNumberFoundEvent extends RandomNumberEvent {
  final int primeNumber;
  final Duration elapsedTime;

  PrimeNumberFoundEvent({required this.primeNumber, required this.elapsedTime});

  @override
  List<Object?> get props => [primeNumber, elapsedTime];
}
