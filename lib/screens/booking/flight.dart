import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipe_app/components/checkbox.dart';
import 'package:recipe_app/components/custom_nav_bar.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
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
    if(widget._destination == null) widget._destination = 'Seoul';
    if(widget._dateRange == null) widget._dateRange = DateTimeRange(start: DateTime.now(), end: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+4));
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildTicket(screenHeight, widget._dateRange, widget._destination, context),
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

SliverToBoxAdapter _buildTicket(double screenHeight, DateTimeRange dateRange, String destination, context) {
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
                borderRadius: BorderRadius.circular(24)),
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
                      "ICN",
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
                      "HKG",
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
                          "Seoul",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      "3H 30M",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          'Hong Kong',
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
                      "10:00 AM",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "02:30 PM",
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
                          "CX8987",
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
                      child: Text(
                        "Upgrade +\$200",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.dark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
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
                        onPressed: () {},
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
                borderRadius: BorderRadius.circular(24),
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
                      "HKG",
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
                      "ICN",
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
                          "Hong Kong",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )),
                    Text(
                      "3H 30M",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark),
                    ),
                    SizedBox(
                        width: 100,
                        child: Text(
                          'Seoul',
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
                      "06:00 PM",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "08:30 PM",
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
                          "CX8986",
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
                      child: Text(
                        "Upgrade +\$200",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
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
                        onPressed: () {},
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
                borderRadius: BorderRadius.circular(24)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Star Hotel  4 nights'),
                    Text('Standard Room'),
                  ],
                ),
                SizedBox(height: 8,),
                Divider(color: AppColors.kPrimaryColor.withOpacity(0.4),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Upgrade +\$200",
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
                        onPressed: () {},
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
                borderRadius: BorderRadius.circular(24)),
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
              showDialog(
                context: context,
                builder: (context) {
                  return confirmDialog(context);
                }
              );
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

Widget confirmDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 200,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
      decoration: BoxDecoration(
        color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8)]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confirm flight and hotel selection', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Pangram', color: AppColors.kPrimaryColor, fontSize: 18),),
          SizedBox(height: 16,),
          Text('Note: You can change your flights and hotels 24 hours before your trip.'),
          SizedBox(height: 32,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {Navigator.pop(context);},
                child: Text('Cancel'),),
              SizedBox(width: 16,),
              TextButton(
                  onPressed: () async {},
                  child: Text('Proceed to payment')),
            ],
          )
        ],
      ),
    ),
  );
}
