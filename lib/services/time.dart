import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TimeService {
  Future<List<String>> getTime() async {
    print('calling fetch time.....');
    List<dynamic> locations;

    try {
      final response =
          await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/'));
      locations = jsonDecode(response.body);
    } catch (e) {
      print('caught error: $e');
      return [];
    }

    String time;
    String location = locations[Random().nextInt(locations.length)] as String;
    try {
      final response = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/$location'));
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime date = DateTime.parse(dateTime);
      date = date.add(Duration(hours: int.parse(offset)));
      time = DateFormat.jm().format(date);
    } catch (e) {
      print('caught error: $e');
      time = "could not fetch time data";
      return [];
    }
    List<String> val = location.split("/");
    location = "${val[1]}, ${val[0]}";
    List<String> locationTime = [];
    locationTime.add(time);
    locationTime.add(location);
    return locationTime;
  }
}
