part of 'time_cubit.dart';

class TimeState {
  final int counter;
  final String location;
  final String time;

  TimeState({
    this.counter = 0,
    this.location = '',
    this.time = "00:00",
  });

  TimeState copyWith({
    int? counter,
    String? location,
    String? time,
  }) {
    return TimeState(
      counter: counter ?? this.counter,
      location: location ?? this.location,
      time: time ?? this.time,
    );
  }
}
