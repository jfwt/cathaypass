import 'package:flutter/material.dart';
import 'package:recipe_app/components/custom_nav_bar.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';

class FlightSelection extends StatefulWidget {
  const FlightSelection({Key key}) : super(key: key);

  @override
  _FlightSelectionState createState() => _FlightSelectionState();
}

class _FlightSelectionState extends State<FlightSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Flight selection',),
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          Container(
            child: Text('test'),
          )
          //_buildHeader(screenHeight),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
