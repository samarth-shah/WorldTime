import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart';


class WorldTime {

  String location;
  String time;
  String flag;
  String url;
  bool isDatetime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      print(url);
      Map data = jsonDecode(response.body) as Map;

      String datetime = data['datetime'] as String;
      String offset = data['utc_offset'].substring(0,3) as String;
      String offsetM = data['utc_offset'].substring(4,6) as String;

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offsetM)));

      // ignore: avoid_bool_literals_in_conditional_expressions
      isDatetime = now.hour > 6 && now.hour < 19 ? true : false ;

      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Caught Erroe $e');
      time = 'Could not get time data ';
    }


  }

}
