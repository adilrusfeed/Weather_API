// ignore_for_file: prefer_const_constructors

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_api/controller/weather_provider.dart';
import 'package:weather_api/screens/home_page.dart';

class HomeProvider extends ChangeNotifier {
  Future checkInternet() async {
    var connectivityresult = await Connectivity().checkConnectivity();
    return connectivityresult != ConnectivityResult.none;
  }

  

  searchCity(context) async {
    final prov = Provider.of<WeatherProvider>(context, listen: false);
    await prov.fetchWeatherDataByCity(cityCoontroller.text.trim(), context);
    cityCoontroller.clear();

    if (prov.weather == null) {
      final snackBar = SnackBar(
          backgroundColor: Colors.red, content: Text("error fetching data"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
