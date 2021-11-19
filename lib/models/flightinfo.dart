import 'package:intl/intl.dart';

class FlightInfo{
  String flightFrom;
  String flightTo;
  String flightFromCity;
  String flightToCity;
  String flightNumber;
  String takeOffTime;
  String landingTime;
  String duration;
  String date;
  bool selected;

  FlightInfo({this.flightFrom, this.flightTo, this.flightNumber, this.flightFromCity, this.flightToCity, this.takeOffTime, this.landingTime, this.duration, this.date, this.selected = false});
}

List<FlightInfo> generateFlightInfo(String destination, DateTime date, bool outBound) {
  DateFormat dateFormatFullEn = DateFormat('dd MMM yyyy',);
  List<FlightInfo> hkgToIcn =  [
    FlightInfo(
      flightFrom: 'HKG',
      flightTo: 'ICN',
      flightFromCity: 'Hong Kong',
      flightToCity: 'Seoul',
      flightNumber: 'CX418',
      duration: '3H 30M',
      takeOffTime: '01:35 PM',
      landingTime: '06:05 PM',
      date: '${dateFormatFullEn.format(date)}',
      selected: true,
    ),
    FlightInfo(
      flightFrom: 'HKG',
      flightTo: 'ICN',
      flightFromCity: 'Hong Kong',
      flightToCity: 'Seoul',
      flightNumber: 'CX410',
      duration: '3H 35M',
      takeOffTime: '09:20 AM',
      landingTime: '01:55 PM',
      date: '${dateFormatFullEn.format(date)}',
    ),
  ];

  List<FlightInfo> icnToHkg =  [
    FlightInfo(
      flightFrom: 'ICN',
      flightTo: 'HKG',
      flightFromCity: 'Seoul',
      flightToCity: 'Hong Kong',
      flightNumber: 'CX419',
      duration: '4H 05M',
      takeOffTime: '07:35 PM',
      landingTime: '10:40 PM',
      date: '${dateFormatFullEn.format(date)}',
      selected: true,
    ),
    FlightInfo(
      flightFrom: 'ICN',
      flightTo: 'HKG',
      flightFromCity: 'Seoul',
      flightToCity: 'Hong Kong',
      flightNumber: 'CX411',
      duration: '4H 10M',
      takeOffTime: '03:00 PM',
      landingTime: '06:10 PM',
      date: '${dateFormatFullEn.format(date)}',
    ),
  ];

  switch(destination) {
    case 'Seoul':
      return outBound? hkgToIcn : icnToHkg;
    default:
      return outBound? hkgToIcn : icnToHkg;
  }
}