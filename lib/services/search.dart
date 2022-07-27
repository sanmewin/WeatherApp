import 'package:flutter/material.dart';
import 'package:weather_app/json/condition.dart';
import 'package:weather_app/json/json.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/cityForecasting.dart';

import '../main.dart';

class SearchCity extends StatefulWidget {
  const SearchCity({Key? key}) : super(key: key);

  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  TextEditingController cityContoller = TextEditingController();
  String city = "London";
  Future<Weather> cityWeather() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=b056a6201885b0b4ec820c308df3a343&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.statusCode);
      return weatherFromJson(response.body);
    }
    return throw Exception();
  }

  WeatherStatus statusWeather = WeatherStatus();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: cityWeather(),
          builder: (context, AsyncSnapshot<Weather> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              var weatherIcon = statusWeather.getWeatherIcon(data!.cod);
              var showMessage =
                  statusWeather.getMessage(data.main.temp.toInt());
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: cityContoller,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: const Color(0xffeceff2),
                              filled: true,
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Color(0xffeceff2))),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Color(0xffeceff2)),
                              ),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    city = cityContoller.text;
                                  });
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Search a City',
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18)),
                          onSubmitted: (value) {
                            city = cityContoller.text;
                            const SearchCity();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ListTile(
                        title: Text(
                          data.name,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text("${data.sys.country}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.normal)),
                      ),
                    ),
                    Text(
                      statusWeather.getWeatherIcon(data.cod),
                      style: const TextStyle(
                        fontSize: 150,
                      ),
                    ),
                    Text(data.weather[0].description,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('${data.main.temp.toInt().toString()}°',
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'H:${data.main.tempMax.toInt().toString()}°',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'L:${data.main.tempMin.toInt().toString()}°',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SearchFore())));
                        },
                        child:  Text(
                          "You can see forecasting here.",
                          style: TextStyle(color: (MyApp.themeNotifier.value ==
                                          ThemeMode.light
                                      ? Colors.black
                                      : Colors.white)),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              "Humidity",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text('${data.main.humidity.toString()}%',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                          ),
                          ListTile(
                            title: const Text(
                              "Pressure",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(data.main.pressure.toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                          ),
                          ListTile(
                            title: const Text(
                              "Wind",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text("${data.wind.speed.toString()} km/h",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                          ),
                          ListTile(
                            title: const Text(
                              "Suggestion",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(showMessage,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding:const  EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: cityContoller,
                          decoration: InputDecoration(
                              fillColor: const Color(0xffeceff2),
                              filled: true,
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Color(0xffeceff2))),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide:
                                    BorderSide(color: Color(0xffeceff2)),
                              ),
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    city = cityContoller.text;
                                  });
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Search a City',
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18)),
                          onSubmitted: (value) {
                            city = cityContoller.text;
                            const SearchCity();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 300,),
                     Text("City not found!",style: TextStyle(color: (MyApp.themeNotifier.value == ThemeMode.light
                                ? Colors.black
                                : Colors.white),fontSize: 20),)
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  Text(
                    "Wait a second",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
