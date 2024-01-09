// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weather_api/services/location_provider.dart';
import 'package:weather_api/services/weather_service_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    // final locationProvider = Provider.of<LocationProvider>(context);
    // final weatherProvider =
    //     Provider.of<WeatherServiceProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        var city = locationProvider.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .fetchWeatherDataByCity(city);
        }
      }
    });

    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
  var city;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final locationProvider = Provider.of<LocationProvider>(context);
    final weatherProvider = Provider.of<WeatherServiceProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/img/clouds.jpg"))),
        child: Stack(
          children: [
            Container(
              height: 50,
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  var locationLocality;
                  if (locationProvider.currentLocationName != null) {
                    locationLocality =
                        locationProvider.currentLocationName!.locality;
                  } else {
                    locationLocality = "Unknown Location";
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locationLocality,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "Good Morning",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _clicked = !_clicked;
                            });
                          },
                          icon: Icon(
                            Icons.search,
                            size: 40,
                          ))
                    ],
                  );
                },
              ),
            ),
            Align(
                alignment: Alignment(0, -0.65),
                child: Image.asset("assets/img/sun.png")),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " ${weatherProvider.weather?.temp?.toStringAsFixed(2)}\u00B0 C" ??
                          "N/A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      weatherProvider.weather?.name ?? "N/A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      weatherProvider.weather?.clouds ?? "N/A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      DateFormat("hh:mm a | EEE   dd-MM-yyyy")
                          .format(DateTime.now()),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.9, 0.75),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4)),
                  height: 180,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/temperature-high.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp Max",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${weatherProvider.weather?.temp_max!.toStringAsFixed(2)}\u00b0 C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/temperature-low.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp min",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "${weatherProvider.weather?.temp_min!.toStringAsFixed(2)}\u00b0 C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          indent: 25,
                          endIndent: 33,
                          thickness: 3,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/sun.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sunrise",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      weatherProvider.weather?.sunrise != null
                                          ? DateFormat("hh:mm a").format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                weatherProvider
                                                        .weather!.sunrise! *
                                                    1000,
                                              ),
                                            )
                                          : "N/A",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/moon.png",
                                  height: 40,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sunset",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      weatherProvider.weather?.sunrise != null
                                          ? DateFormat("hh:mm a").format(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                weatherProvider
                                                        .weather!.sunset! *
                                                    1000,
                                              ),
                                            )
                                          : "N/A",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ])),
            ),
            Positioned(
              top: 60,
              right: 20,
              left: 20,
              child: Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: "search city...",
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          print(_searchController.text);
                          weatherProvider
                              .fetchWeatherDataByCity(_searchController.text);
                        },
                        icon: Icon(Icons.search))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
