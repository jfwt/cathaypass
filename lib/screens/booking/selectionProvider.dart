import 'package:flutter/material.dart';
import 'package:recipe_app/models/flightinfo.dart';
import 'package:recipe_app/models/hotelinfo.dart';

class SelectionProvider extends ChangeNotifier{

  int inboundFlightIndex = 0;
  int outboundFlightIndex = 0;
  int hotelIndex = 0;

  void changeFlightSelection(List<FlightInfo> flightList, int index, bool outbound) {
    flightList.forEach((element) {
      element.selected = false;
    });
    flightList[index].selected = true;
    outbound? outboundFlightIndex = index : inboundFlightIndex = index;
    notifyListeners();
  }

  void changeHotelSelection(List<HotelInfo> hotelList, int index) {
    hotelList.forEach((element) {
      element.selected = false;
    });
    hotelList[index].selected = true;
    hotelIndex = index;
    notifyListeners();
  }

  bool getSelected(List<FlightInfo> flightList, int index) {
    return flightList[index].selected;
  }

  bool getSelectedHotel(List<HotelInfo> hotelList, int index) {
    return hotelList[index].selected;
  }

  int getIndex(String info) {
    if(info == 'inboundFlight') return inboundFlightIndex;
    if(info == 'outboundFlight') return outboundFlightIndex;
    if(info == 'hotel') return hotelIndex;
  }

  void confirmTrip() {

  }
}