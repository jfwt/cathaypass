import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/custom_nav_bar.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/flightinfo.dart';
import 'package:recipe_app/models/trip.dart';
import 'package:recipe_app/screens/booking/selectionProvider.dart';

class FlightSelection extends StatefulWidget {

  DateTimeRange _dateRange;
  String _destination;
  bool _outbound;

  FlightSelection({DateTimeRange dateRange, String destination, bool outbound}): _dateRange = dateRange, _destination = destination, _outbound = outbound;
  // const FlightSelection({Key key}) : super(key: key);

  @override
  _FlightSelectionState createState() => _FlightSelectionState();
}

class _FlightSelectionState extends State<FlightSelection> {
  @override
  Widget build(BuildContext context) {
    SelectionProvider selectionProvider = Provider.of<SelectionProvider>(context, listen: true);
    if(widget._destination == null) widget._destination = 'Seoul';
    if(widget._dateRange == null) widget._dateRange = DateTimeRange(start: DateTime.now(), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+4));
    List<FlightInfo> flightList = generateFlightInfo('Seoul', DateTime.now(), widget._outbound);
    return Scaffold(
      appBar: CustomAppBar(title: 'Flight selection',),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            widget._outbound ? Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.flight_takeoff, color: AppColors.kTextLigntColor),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Outbound Flight",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ) : Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.flight_land, color: AppColors.kTextLigntColor),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Inbound Flight",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.dark,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Expanded(child: ListView.builder(
              itemCount: flightList.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.white,
                      border: Border.all(color: selectionProvider.getSelected(flightList, index)? AppColors.kPrimaryColor:AppColors.white)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Text(
                            flightList[index].flightFrom,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kPrimaryColor),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: AppColors.kTextLigntColor,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    height: 24,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Flex(
                                          children: List.generate(
                                              (constraints.constrainWidth() / 6)
                                                  .floor(),
                                                  (index) => SizedBox(
                                                height: 1,
                                                width: 3,
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color:
                                                      Colors.grey.shade300),
                                                ),
                                              )),
                                          direction: Axis.horizontal,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                        );
                                      },
                                    ),
                                  ),
                                  Center(
                                      child: Transform.rotate(
                                        angle: 1.5,
                                        child: Icon(
                                          Icons.local_airport,
                                          color: AppColors.premiumEconClassColor,
                                          size: 24,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(20)),
                            child: SizedBox(
                              height: 8,
                              width: 8,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: AppColors.kTextLigntColor,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            flightList[index].flightTo,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kPrimaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              width: 100,
                              child: Text(
                                flightList[index].flightFromCity,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                          Text(
                            flightList[index].duration,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.dark),
                          ),
                          SizedBox(
                              width: 100,
                              child: Text(
                                flightList[index].flightToCity,
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            flightList[index].takeOffTime,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.dark,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            flightList[index].landingTime,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.dark,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            flightList[index].date,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Flight No : ",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                flightList[index].flightNumber,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.dark),
                              ),
                              Text(
                                " (Economy)",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      selectionProvider.getSelected(flightList, index) ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Selected', style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ) : Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.kPrimaryColor),
                          child: TextButton(
                            onPressed: () {
                              selectionProvider.changeFlightSelection(flightList, index, widget._outbound);
                              print(selectionProvider.getSelected(flightList, index));
                            },
                            child: Text('Select', style: TextStyle(color: AppColors.white),),
                          ),
                        ),
                      )
                    ],
                  )
                )
            ),),
            FlatButton.icon(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 18.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: AppColors.kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              icon: const Icon(
                Icons.airplane_ticket,
                color: Colors.white,
              ),
              label: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      )
    );
  }
}
