import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    try {
      //make the request
      http.Response response = await http.get(
        Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=$url'),
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print('===============================');
        String datetime = data['dateTime'];
        String timeZone = data['timeZone'];

        print(datetime);
        print(timeZone);
        print('===============================');
        DateTime now = DateTime.parse(datetime);
        print(now);


        isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

        time = DateFormat.jm().format(now);
      }else {
        time = 'Could not get time data';
      }
    } catch (e) {
      print('Caught Error: $e');
      time = 'Could not get time data';
    }
  }
}

