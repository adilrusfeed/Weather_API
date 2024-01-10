import 'package:flutter/material.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/services/weather_service_provider.dart';


class WeatherProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  WeatherModel? data;

  Future<WeatherModel?> getData(String place) async {
    isLoading = true;
    notifyListeners();

    data = await WeatherApiClient().getCurrentWeather(place);

    isLoading = false;
    notifyListeners();

    return data;
  }

  void getdata() {
    data = null;
    notifyListeners();
  }
}
