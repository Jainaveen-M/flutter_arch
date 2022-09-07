import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_arch/data/repo/time.dart';
import 'package:meta/meta.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeState());

  void updateTimeLocation() async {
    List<String> timeLocatioon = await TimeRepo().getTimeLocation();
    emit(
      state.copyWith(
        location: timeLocatioon[1],
        time: timeLocatioon[0],
      ),
    );
  }
}
