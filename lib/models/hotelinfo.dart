import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelInfo{
  String hotelName;
  String roomType;
  String price;
  bool selected;

  HotelInfo({this.hotelName, this.roomType, this.price, this.selected = false});
}

List<HotelInfo> generateHotelInfo(String destination, DateTimeRange dateRange) {
  DateFormat dateFormatFullEn = DateFormat('dd MMM yyyy',);
  List<HotelInfo> seoul =  [
    HotelInfo(
      hotelName: 'Hotel Cappuccino',
      roomType: 'Standard Room',
      price: '',
      selected: true,
    ),
    HotelInfo(
      hotelName: 'Glad Live Gangnam',
      roomType: 'Standard Double',
      price: '',
    ),
    HotelInfo(
      hotelName: 'Vista Walkerhill Seoul',
      roomType: 'Standard Room',
      price: '+HK\$700',
    ),
    HotelInfo(
      hotelName: 'Signiel Seoul',
      roomType: 'Standard Room',
      price: '+HK\$1000',
    ),
    HotelInfo(
      hotelName: 'Park Hyatt Seoul',
      roomType: 'Standard Room',
      price: '+HK\$1000',
    ),
  ];

  switch(destination) {
    case 'Seoul':
      return seoul;
    default:
      return seoul;
  }
}