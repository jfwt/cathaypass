import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/checkbox.dart';
import 'package:recipe_app/components/custom_nav_bar.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/flightinfo.dart';
import 'package:recipe_app/models/hotelinfo.dart';
import 'package:recipe_app/screens/booking/flightSelection.dart';
import 'package:recipe_app/screens/booking/hotelSelection.dart';
import 'package:recipe_app/screens/booking/selectionProvider.dart';
import 'package:recipe_app/screens/covid/menu.dart';

class BookScreen extends StatefulWidget {
  DateTimeRange _dateRange;
  String _destination;

  BookScreen({DateTimeRange dateRange, String destination}): _dateRange = dateRange, _destination = destination;

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  static DateFormat dateFormatEn = DateFormat('dd MMM');

  @override
  Widget build(BuildContext context) {
    SelectionProvider selectionProvider = Provider.of<SelectionProvider>(context, listen: true);
    if(widget._destination == null) widget._destination = 'Seoul';
    if(widget._dateRange == null) widget._dateRange = DateTimeRange(start: DateTime.now(), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+4));
    List<FlightInfo> flightListOutbound = generateFlightInfo(widget._destination, widget._dateRange.start, true);
    List<FlightInfo> flightListInbound = generateFlightInfo(widget._destination, widget._dateRange.start, false);
    List<HotelInfo> hotelList = generateHotelInfo(widget._destination, widget._dateRange);

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildTicket(screenHeight, widget._dateRange, widget._destination, context, selectionProvider, flightListOutbound, flightListInbound, hotelList),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'HKG → ICN',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontFamily: 'Pangram',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: screenHeight * 0.01),
                Row(
                  children: [
                    SizedBox(width: 8,),
                    Text(
                      '1 Adult',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(width: 12,),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(4)),
                      child: Center(child: IconButton(onPressed: () {}, icon: Icon(Icons.add, color: Colors.white54, size: 16,))),),
                    Expanded(child: SizedBox(width: 32,)),
                    Text(
                      '${dateFormatEn.format(widget._dateRange.start)} - ${dateFormatEn.format(widget._dateRange.end)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(width: 16,)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

SliverToBoxAdapter _buildTicket(double screenHeight, DateTimeRange dateRange, String destination, BuildContext context, SelectionProvider selectionProvider, List<FlightInfo> flightListOutbound, List<FlightInfo> flightListInbound, List<HotelInfo> hotelList) {
  bool isChecked = true;
  DateFormat dateFormatFullEn = DateFormat('dd MMM yyyy',);

  return SliverToBoxAdapter(
    child: Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 16,),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                'Recommended for you:',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Pangram'
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: <Widget>[
                Center(
                  child: Row(
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      flightListOutbound[selectionProvider.getIndex('outboundFlight')].flightFrom,
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
                      flightListOutbound[selectionProvider.getIndex('outboundFlight')].flightTo,
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
                          flightListOutbound[selectionProvider.getIndex('outboundFlight')].flightFromCity,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      flightListOutbound[selectionProvider.getIndex('outboundFlight')].duration,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          flightListOutbound[selectionProvider.getIndex('outboundFlight')].flightToCity,
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
                      flightListOutbound[selectionProvider.getIndex('outboundFlight')].takeOffTime,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flightListOutbound[selectionProvider.getIndex('outboundFlight')].landingTime,
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
                      '${dateFormatFullEn.format(dateRange.start)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Flight No : ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          flightListOutbound[selectionProvider.getIndex('outboundFlight')].flightNumber,
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
                Divider(color: AppColors.kPrimaryColor.withOpacity(0.4),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Upgrade +\$200",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          MyStatefulWidget(),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.kPrimaryColor
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FlightSelection(destination: destination, dateRange: dateRange, outbound: true,)));
                        },
                        child: Text(
                          "Reselect",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: <Widget>[
                Center(
                  child: Row(
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
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      flightListInbound[selectionProvider.getIndex('inboundFlight')].flightFrom,
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
                      flightListInbound[selectionProvider.getIndex('inboundFlight')].flightTo,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor),
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        width: 100,
                        child: Text(
                          flightListInbound[selectionProvider.getIndex('inboundFlight')].flightFromCity,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      flightListInbound[selectionProvider.getIndex('inboundFlight')].duration,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          flightListInbound[selectionProvider.getIndex('inboundFlight')].flightToCity,
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
                      flightListInbound[selectionProvider.getIndex('inboundFlight')].takeOffTime,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      flightListInbound[selectionProvider.getIndex('inboundFlight')].landingTime,
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
                      '${dateFormatFullEn.format(dateRange.end)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Flight No : ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          flightListInbound[selectionProvider.getIndex('inboundFlight')].flightNumber,
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
                Divider(color: AppColors.kPrimaryColor.withOpacity(0.4),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "Upgrade +\$200",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: AppColors.dark,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          MyStatefulWidget(),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.kPrimaryColor
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FlightSelection(destination: destination, dateRange: dateRange, outbound: false,)));
                        },
                        child: Text(
                          "Reselect",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightSand.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.hotel, color: AppColors.darkSandColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Hotel",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(hotelList[selectionProvider.getIndex('hotel')].hotelName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Pangram'),),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(hotelList[selectionProvider.getIndex('hotel')].roomType, style: TextStyle(fontWeight: FontWeight.w600),),
                    SizedBox(width: 16,),
                    Text('${dateRange.end.day - dateRange.start.day} nights'),
                  ],
                ),
                SizedBox(height: 8,),
                Divider(color: AppColors.kPrimaryColor.withOpacity(0.4),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${hotelList[selectionProvider.getIndex('hotel')].price}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.kPrimaryColor
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HotelSelection(destination: destination, dateRange: dateRange,)));
                        },
                        child: Text(
                          "Reselect",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          // insurance page
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.premiumEconClassColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.health_and_safety, color: AppColors.businessClassColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Insurance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Your trip is protected by CHUBB",
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    MyStatefulWidget(),
                  ],
                ),
                TextButton(child: Text('or Change a plan'), onPressed: () {},)
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          FlatButton.icon(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 18.0,
            ),
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
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
    ),
  );
}
