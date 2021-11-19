import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/booking/flight.dart';
import 'package:recipe_app/screens/reselect/reselectpage.dart';

class TripCard extends StatefulWidget {
  String _tripNumber;
  String _destination;
  List<String> _destinationList;
  String _warning;
  bool _plannedTrip;
  Function _callback;

  TripCard({String tripNumber, String destination, List<String> destinationList, String warning, bool plannedTrip, Function callback,}) : _tripNumber = tripNumber, _destination = destination, _destinationList = destinationList, _warning = warning, _plannedTrip = plannedTrip, _callback = callback;

  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  //DateTimeRange initialDateRange = DateTimeRange(start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+7), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+14));
  DateTimeRange pickedDateRange;
  static DateFormat dateFormatEn = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    return Container(
        //width: SizeConfig.screenWidth*0.9,
        height: widget._warning == '' ? 180 : 200,
        padding: EdgeInsets.fromLTRB(16,16,16,24),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage('assets/images/${widget._destination.toLowerCase().split(' ').first}.jpg'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
            )
        ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget._tripNumber, style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'Pangram', fontWeight: FontWeight.w600),),
                      SizedBox(width: 8,),
                      if(widget._plannedTrip) Container(child: Text('CONFIRMED', style: TextStyle(color: AppColors.lightSlate, fontWeight: FontWeight.w600),), padding: EdgeInsets.only(top: 8),),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  child: TextButton(
                      onPressed: () {
                        Future.delayed(Duration(seconds: 1), () {
                          if(widget._callback != null) widget._callback();
                        });
                        if(widget._destination != null && pickedDateRange != null)
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookScreen(dateRange: pickedDateRange,)));
                      },
                      child: Icon(Icons.edit, color: Colors.white,)
                  ),
                )
                /*Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.kPrimaryColor),
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Start planning', style: TextStyle(color: AppColors.white, fontSize: 18),),
                  ),
                )*/
              ],
            ),
            if(widget._warning != '') GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReselectPage())),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 180,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Color(0xFFFD2F22)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_rounded, color: Colors.white, size: 16,),
                      SizedBox(width: 8,),
                      Text(widget._warning, style: TextStyle(color: Colors.white),),
                    ],
                  )
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(child: Text('Destination', style: TextStyle(color: Colors.white, fontFamily: 'Pangram', fontWeight: FontWeight.w600),), padding: EdgeInsets.only(left: 8),),
                      SizedBox(height: 8,),
                      Container(
                        padding: EdgeInsets.fromLTRB(16,0,8,0),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            items: widget._destinationList.map((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14),),
                              );
                            }).toList(),
                            value: widget._destination,
                            onChanged: (val) {
                              setState(() => widget._destination = val,);
                              },
                        ),
                      ))
                    ]
                  ),
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(child: Text('Date', style: TextStyle(color: Colors.white, fontFamily: 'Pangram', fontWeight: FontWeight.w600),), padding: EdgeInsets.only(left: 8),),
                    SizedBox(height: 8,),
                    Container(
                      padding: EdgeInsets.fromLTRB(16,0,8,0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white, ),
                      child: Row(
                        children: [
                          pickedDateRange!=null ? Text('${dateFormatEn.format(pickedDateRange.start)} - ${dateFormatEn.format(pickedDateRange.end)}') : SizedBox(width: 64,),
                          // pickedDateRange!=null ? Text('${dateFormatEn.format(pickedDateRange.start)} - ${dateFormatEn.format(pickedDateRange.end)}') :
                          //Text('${dateFormatEn.format(initialDateRange.start)} - ${dateFormatEn.format(initialDateRange.end)}'),
                          Container(
                              width: 32, height: 40,
                              child: IconButton(
                                  onPressed: () {dateTimeRangePicker();},
                                  icon: Icon(Icons.calendar_today, size: 20,)
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        )
    );
  }

  dateTimeRangePicker() async {
    pickedDateRange = await showDateRangePicker(
        context: context,
        //initialDateRange: DateTimeRange(start: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+7), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+14)),
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime.utc(2022, 12, 31),
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.8, maxHeight: 540),
                  child: child,
                ),
              )
            ],
          );
        });
    setState(() {
      pickedDateRange = pickedDateRange;
    });
    // print(pickedDateRange);
  }
}