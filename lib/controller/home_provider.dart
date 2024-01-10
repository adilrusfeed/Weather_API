import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_api/controller/location_provider.dart';
import 'package:weather_api/controller/weather_provider.dart';
import 'package:weather_api/screens/home_page.dart';

class HomeProvider extends ChangeNotifier {
  Future checkInternet() async {
    var connectivityresult = await Connectivity().checkConnectivity();
    return connectivityresult != ConnectivityResult.none;
  }

  Future<void> checkInternetAndFetchData(context) async {
    final hasInternet = await checkInternet();

    if (!hasInternet) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please check your internet connection. Please restart the app after the network is stabled'),
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

  searchCity(context) async {
    final prov = Provider.of<WeatherProvider>(context, listen: false);
    await prov.fetchWeatherDataByCity(cityCoontroller.text.trim(), context);
    cityCoontroller.clear();

    if (prov.weather == null) {
      final snackBar = SnackBar(
          backgroundColor: Colors.red, content: Text("City not found"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
