import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Forecast/forecastJson.dart';
import 'package:http/http.dart' as http;

import '../json/condition.dart';
import '../main.dart';

class SearchFore extends StatefulWidget {
  const SearchFore({Key? key}) : super(key: key);

  @override
  State<SearchFore> createState() => _SearchForeState();
}

WeatherStatus weatherStatus = WeatherStatus();
TextEditingController cityContoller = TextEditingController();
DateTime dateTime = DateTime.now();
String city = "London";
Future<WeatherForecast> cityWeatherForecast() async {
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=831a2334be8e9b83b2a4f40868fde2ab&units=metric");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.statusCode);
    return weatherForecastFromJson(response.body);
  }
  return throw Exception();
}

class _SearchForeState extends State<SearchFore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: cityWeatherForecast(),
          builder: (context, AsyncSnapshot<WeatherForecast> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              var weatherIcon =
                  weatherStatus.getWeatherIcon(data!.list[0].main.temp.toInt());
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffeceff2),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding:  EdgeInsets.only(right: 60),
                            child: Text(
                              "Today's forecasting in every 3 hours",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 10,
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[7].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[7].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[7].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        DateFormat.Hm()
                                            .format(data.list[0].dtTxt),
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      Text(
                                        weatherStatus.getWeatherIcon(
                                            data.list[0].weather[0].id),
                                        style: const TextStyle(fontSize: 35),
                                      ),
                                      Text(
                                          "${data.list[0].main.temp.toStringAsFixed(0)}°",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[1].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[1].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[1].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[2].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[2].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[2].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[3].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[3].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[3].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[4].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[4].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[4].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[5].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[5].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[5].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.Hm()
                                          .format(data.list[6].dtTxt),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      weatherStatus.getWeatherIcon(
                                          data.list[6].weather[0].id),
                                      style: const TextStyle(fontSize: 35),
                                    ),
                                    Text(
                                      "${data.list[6].main.temp.toStringAsFixed(0)}°",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffeceff2),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "5-DAY FORECAST",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 10,
                            thickness: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                          ListTile(
                            leading: Text(
                              DateFormat.EEEE().format(dateTime),
                              style:
                                 const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            title: Center(
                              child: Text(
                                weatherStatus
                                    .getWeatherIcon(data.list[8].weather[0].id),
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            trailing: Text(
                              "${data.list[8].main.temp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Text(
                              DateFormat.EEEE().format(data.list[14].dtTxt),
                              style:
                                 const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            title: Center(
                              child: Text(
                                weatherStatus.getWeatherIcon(
                                    data.list[14].weather[0].id),
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            trailing: Text(
                              "${data.list[14].main.temp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Text(
                              DateFormat.EEEE().format(data.list[22].dtTxt),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            title: Center(
                              child: Text(
                                weatherStatus.getWeatherIcon(
                                    data.list[22].weather[0].id),
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            trailing: Text(
                              "${data.list[22].main.temp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Text(
                              DateFormat.EEEE().format(data.list[30].dtTxt),
                              style:
                                 const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            title: Center(
                              child: Text(
                                weatherStatus.getWeatherIcon(
                                    data.list[30].weather[0].id),
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            trailing: Text(
                              "${data.list[30].main.temp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Text(
                              DateFormat.EEEE().format(data.list[38].dtTxt),
                              style:
                                 const TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            title: Center(
                              child: Text(
                                weatherStatus.getWeatherIcon(
                                    data.list[38].weather[0].id),
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                            trailing: Text(
                              "${data.list[38].main.temp.toStringAsFixed(0)}°",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
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
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
