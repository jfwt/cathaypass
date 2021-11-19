class Trip {
  String tripNumber;
  String destination;
  List<String> destinationList;
  String warning;
  bool plannedTrip;

  Trip({this.tripNumber, this.destination, this.destinationList, this.warning, this.plannedTrip});
}

List<Trip> generateTrips() {
  return [
    Trip(
      tripNumber: 'Trip 1',
      destination:  'Seoul',
      destinationList: ['Seoul', 'Busan', 'Tokyo', 'Singapore', 'Bangkok', 'Sydney (+HKD1,000)', 'Paris (+HKD2,000)'],
      warning: '',
      plannedTrip: false,
    ),
    Trip(
      tripNumber: 'Trip 2',
      destination:  'Seoul',
      destinationList: ['Seoul', 'Busan', 'Tokyo', 'Singapore', 'Bangkok', 'Sydney (+HKD1,000)', 'Paris (+HKD2,000)'],
      warning: '',
      plannedTrip: false,
    ),
    Trip(
      tripNumber: 'Trip 3',
      destination:  'Seoul',
      destinationList: ['Seoul', 'Busan', 'Tokyo', 'Singapore', 'Bangkok', 'Sydney (+HKD1,000)', 'Paris (+HKD2,000)'],
      warning: '',
      plannedTrip: false,
    ),
  ];
}