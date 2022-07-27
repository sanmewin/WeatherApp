import 'package:http/http.dart' as http;
import 'package:weather_app/api/location.dart';

import '../json/json.dart';

class getWeather{
  getLocation WeatherLoc =getLocation();
  Future<Weather> showWeather()async{
    await WeatherLoc.locationService();
    var latitude =WeatherLoc.latitude;
    var longitide=WeatherLoc.longitide;
    if(latitude==null || longitide==null){
    }
 else{
  var url =Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitide&appid=b056a6201885b0b4ec820c308df3a343&units=metric");
  var response=await http.get(url);
  if (response.statusCode == 200) {
      return weatherFromJson(response.body);
    } 
  }
  return throw Exception();
 }
  }
  
  

