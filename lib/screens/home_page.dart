// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/controller/home_provider.dart';
import 'package:weather_api/controller/location_provider.dart';
import 'package:weather_api/controller/weather_provider.dart';

TextEditingController cityCoontroller = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeprovider = Provider.of<HomeProvider>(context, listen: false);
    checkInternetAndFetchData(context);
    var currentTime = DateTime.now().hour;
    String greeting;
    if (currentTime >= 4 && currentTime < 12) {
      greeting = "Good Morining";
    } else if (currentTime >= 12 && currentTime < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(15),
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/img/thunder.jpg"))),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<LocatorProvider>(
                        builder: (context, value, child) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.currentLocationName?.locality ??
                                  "unknown location",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            Text(
                              greeting,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityCoontroller,
                      decoration: InputDecoration(
                        labelText: "Search City ...",
                        labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeprovider.searchCity(context);
                    },
                    icon: const Icon(Icons.search),
                    iconSize: 30,
                  )
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Consumer2<WeatherProvider, LocatorProvider>(
                builder: (context, weathervalue, locatorvalue, child) {
                  if (locatorvalue.currentLocationName == null ||
                      weathervalue.weather == null) {
                    return Lottie.asset("assets/img/loading.json");
                  }
                  return Column(
                    children: [
                      Text(
                        "${weathervalue.weather!.temp!.round().toStringAsFixed(1)}\u00b0c",
                        style: const TextStyle(
                          fontSize: 75,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Text(
                        weathervalue.weather!.clouds ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weathervalue.weather!.name?.toUpperCase() ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        DateFormat("hh:mm a | EEE   dd-MM-yyyy")
                            .format(DateTime.now()),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 180,
                child: Consumer2<WeatherProvider, LocatorProvider>(
                  builder: (context, weathervalue, locatorvalue, child) {
                    if (locatorvalue.currentLocationName == null) {
                      // Display a message to select a location
                      return const Center(
                        child: Text(
                          "fetching data",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      );
                    } else {
                      final weather = weathervalue.weather;

                      if (weather == null) {
                        return Text("searching");
                      }
                      return Align(
                        alignment: Alignment(0.9, 0.75),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          height: 180,
                          child: Consumer2<WeatherProvider, LocatorProvider>(
                            builder:
                                (context, weathervalue, locatorvalue, child) {
                              if (locatorvalue.currentLocationName == null) {
                                // Display a message to select a location
                                return const Center(
                                  child: Text(
                                    "Select a location...",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              } else {
                                final weather = weathervalue.weather;

                                if (weather == null) {
                                  return const Text("loading...");
                                }
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/img/temperature-high.png',
                                              height: 53,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Temp Max",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${weather.temp_max?.round().toStringAsFixed(2) ?? "N/A"}\u00b0c",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/img/temperature-low.png',
                                              height: 53,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Temp low",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${weather.temp_min?.round().toStringAsFixed(2) ?? "N/A"}\u00b0c",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      indent: 25,
                                      endIndent: 33,
                                      thickness: 2.5,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 22,
                                              backgroundImage: AssetImage(
                                                  'assets/img/sunrise.png'),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Sunrise",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  DateFormat("hh:mm a").format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      weather.sunrise! * 1000,
                                                    ),
                                                  ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 18),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 22,
                                              backgroundImage: AssetImage(
                                                  'assets/img/sunset.jpg'),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Sunset",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  DateFormat("hh:mm a").format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      weather.sunset! * 1000,
                                                    ),
                                                  ),
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
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkInternetAndFetchData(context) async {
    final hasInternet =
        await Provider.of<HomeProvider>(context).checkInternet();

    if (!hasInternet) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection!'),
            content: const Text('Please check your internet connection.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Internet is available, proceed with fetching data
      final locationProvider =
          Provider.of<LocatorProvider>(context, listen: false);

      locationProvider.determinePosition().then((_) {
        if (locationProvider.currentLocationName != null) {
          var city = locationProvider.currentLocationName?.locality;
          if (city != null) {
            Provider.of<WeatherProvider>(context, listen: false)
                .fetchWeatherDataByCity(city, context);
          }
        }
      });
    }
  }
}
