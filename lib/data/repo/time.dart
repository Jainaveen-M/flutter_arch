import 'package:flutter_bloc_arch/services/time.dart';

class TimeRepo {
  Future<List<String>> getTimeLocation() async {
    List<String> timeLocation = await TimeService().getTime();
    return timeLocation;
  }
}
