import 'package:equatable/equatable.dart';

abstract class RandomNumberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RandomNumberInitial extends RandomNumberState {}

 

class RandomNumberLoaded extends RandomNumberState {
  final int number;

  RandomNumberLoaded({required this.number});

  @override
  List<Object?> get props => [number];
}

class RandomNumberError extends RandomNumberState {
  final String message;

  RandomNumberError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ClockUpdated extends RandomNumberState {
  final String time;
  final String date;

  ClockUpdated({required this.time, required this.date});

  @override
  List<Object?> get props => [time, date];
}

class PrimeNumberDetected extends RandomNumberState {
  final int primeNumber;
  final Duration elapsedTime;

  PrimeNumberDetected({required this.primeNumber, required this.elapsedTime});

  @override
  List<Object?> get props => [primeNumber, elapsedTime];
}
