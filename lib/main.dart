
import 'package:flutter/material.dart';
import 'package:weather_app/Forecast/forecast.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/json/condition.dart';
import 'package:weather_app/services/search.dart';
import 'package:weather_app/ui/efab.dart';
import 'package:weather_app/ui/splashScreen.dart';
import 'dart:math' as math;
import 'api/location.dart';
import 'json/json.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}
class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (BuildContex, ThemeMode currentMode, Widget? widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.grey),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const SplashScreen(),
          );
        });
  }
}

class WeatherApp extends StatefulWidget {
  WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

getLocation locationPer = getLocation();

class _WeatherAppState extends State<WeatherApp> {
  double acwidth =50;
   double acheight =50;
   bool visible=true;
   BorderRadiusGeometry acborderRadius = BorderRadius.circular(8);
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  getWeather gettingWeather = getWeather();
  WeatherStatus weatherStatus = WeatherStatus();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffcbcbe2),
      // backgroundColor: Color(0xfff2f5f6),
      body: FutureBuilder(
          future: gettingWeather.showWeather(),
          builder: (context, AsyncSnapshot<Weather> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              var weatherIcon = weatherStatus.getWeatherIcon(data!.cod);
              var showMessage =
                  weatherStatus.getMessage(data.main.temp.toInt());
              return Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Icons.dark_mode
                            : Icons.light_mode,
                      ),
                      onPressed: () {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                      },
                    ),
                    title: const Center(
                        child: Text(
                      "Weather",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                    trailing: IconButton(
                        onPressed: () {
                          locationPer.locationService();
                        },
                        icon: Icon(Icons.location_on,
                            color: (MyApp.themeNotifier.value == ThemeMode.light
                                ? Colors.black
                                : Colors.white))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Text(
                    ("${data.name},${data.sys.country}"),
                    style: TextStyle(
                        color: (MyApp.themeNotifier.value == ThemeMode.light
                            ? Colors.black
                            : Colors.white),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
                  Text(
                    weatherStatus.getWeatherIcon(data.cod),
                    style: const TextStyle(
                      fontSize: 140,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 180,
                    width: 380,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xffeceff2),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data.main.temp.toInt().toString()}°',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          showMessage,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.weather[0].description,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'H:${data.main.tempMax.toInt().toString()}°',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'L:${data.main.tempMin.toInt().toString()}°',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   data.weather[0].description,
                  //   style:const  TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.normal,
                  //       fontSize: 20),
                  // ),
                 const  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        commonCart(
                          data: "${data.wind.speed.toString()} km/h",
                          text: "Wind",
                          size: 15,
                          size2: 18,
                          fontWeight: FontWeight.bold,
                          fontWeight2: FontWeight.normal,
                          icon: Icons.air,
                        ),
                       const SizedBox(
                          width: 10,
                        ),
                        commonCart(
                          data: '${data.main.temp.toInt().toString()}°',
                          text: "Temperature",
                          size: 15,
                          size2: 20,
                          fontWeight: FontWeight.bold,
                          fontWeight2: FontWeight.normal,
                          icon: Icons.device_thermostat,
                        ),
                      ],
                    ),
                  ),
                 const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => Forecast())));
                          },
                          child:  commonCart(
                            data:data.main.seaLevel.toString() ,
                            text: "Sea Level",
                            size: 15,
                            size2: 20,
                            fontWeight: FontWeight.bold,
                            fontWeight2: FontWeight.normal,
                            icon: Icons.line_axis,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        commonCart(
                          data: '${data.main.humidity.toString()}%',
                          text: "Humidity",
                          size: 15,
                          size2: 20,
                          fontWeight: FontWeight.bold,
                          fontWeight2: FontWeight.normal,
                          icon: Icons.water_drop_outlined,
                        ),
                      ],
                    ),
                  ),
                  // Text(
                  //   weatherStatus.getWeatherIcon(data.id),
                  //   style:const  TextStyle(
                  //     fontSize: 100,
                  //   ),
                  // ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Something went Wrong");
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
          floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: (){
                setState(() {
                  final random=math.Random();
                
              acwidth=random.nextInt(300).toDouble();
              acheight=random.nextInt(300).toDouble();
              acborderRadius=BorderRadius.circular(random.nextInt(100).toDouble()
              );
                });
            },
            icon: const Icon(Icons.format_size),
          ),
          ActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => Forecast())));
            },
            icon: const Icon(Icons.cloud),
          ),
          ActionButton(
            onPressed: (){
              Navigator.push(
              context, MaterialPageRoute(builder: ((context) => SearchCity())));
            },
            icon: const Icon(
          Icons.search,
          size: 25,
        ),
          ),
        ],
      ),
      
    );
  }
}

class commonCart extends StatelessWidget {
  const commonCart({
    Key? key,
    required this.data,
    required this.text,
    required this.size,
    required this.fontWeight,
    required this.size2,
    required this.fontWeight2,
    required this.icon,
  }) : super(key: key);

  final String data;
  final String text;
  final double size;
  final double size2;
  final FontWeight fontWeight;
  final FontWeight fontWeight2;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 190,
      decoration: const BoxDecoration(
          color: Color(0xffeceff2),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Center(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
                fontSize: size,
                fontWeight: fontWeight2,
                color: Colors.black),
          ),
          subtitle: Text(
            data,
            style: TextStyle(
                color: Colors.black, fontSize: size2, fontWeight: fontWeight),
          ),
        ),
      ),
    );
  }
}
