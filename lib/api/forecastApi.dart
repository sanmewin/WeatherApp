import 'package:weather_app/Forecast/forecastJson.dart';
import 'package:http/http.dart' as http;
import 'location.dart';

class getForecast{
  getLocation forecastLoc =getLocation();
  Future<WeatherForecast> showForecast()async{
    await forecastLoc.locationService();
    var latitude =forecastLoc.latitude;
    var longitide=forecastLoc.longitide;
    if(latitude==null || longitide==null){
    }
 else{
  var url =Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitide&appid=831a2334be8e9b83b2a4f40868fde2ab&units=metric");
  var response=await http.get(url);
  if (response.statusCode == 200) {
      return weatherForecastFromJson(response.body);
    } 
  }
  return throw Exception();
 }
  }