import 'package:flutter/material.dart';
import 'package:recipe_app/models/flightinfo.dart';

class SelectionProvider extends ChangeNotifier{

  void changeFlightSelection(List<FlightInfo> flightList, int index) {
    flightList.forEach((element) {
      element.selected = false;
    });
    flightList[index].selected = true;
    notifyListeners();
  }

  bool getSelected(List<FlightInfo> flightList, int index) {
    return flightList[index].selected;
  }
}