import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/task.dart';
import 'package:recipe_app/screens/booking/hotel.dart';
import 'package:recipe_app/screens/booking/flight.dart';
import 'package:recipe_app/screens/covid/menu.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/screens/profile/profile_screen.dart';
import 'package:recipe_app/screens/subscription/subscriptionpage.dart';
import 'package:recipe_app/widgets/calendarpage.dart';

class NavItem {
  final int id;
  final Icon icon;
  final Widget destination;

  NavItem({this.id, this.icon, this.destination});

// If there is no destination then it help us
  bool destinationChecker() {
    if (destination != null) {
      return true;
    }
    return false;
  }
}

// If we made any changes here Provider package rebuid those widget those use this NavItems
class NavItems extends ChangeNotifier {
  // By default first one is selected
  int selectedIndex = 0;

  void chnageNavIndex({int index}) {
    selectedIndex = index;
    // if any changes made it notify widgets that use the value
    notifyListeners();
  }

  List<NavItem> items = [
    NavItem(
      id: 1,
      icon: Icon(Icons.home),
      //destination: HomeScreen(),
      destination: CalendarPage(Task(
        iconData: Icon(Icons.person_rounded),
        title: 'Personal',
        bgColor: Colors.purple,
        iconColor: Colors.orange,
        btnColor: Colors.yellow,
        left: 3,
        done: 1,
        desc: [
          {
            'time': '9:00 am',
            'title': 'Arrive at Airport',
            'slot': '9:00 - 10:00 am',
            'tlColor': AppColors.green,
            'bgColor': AppColors.green.withOpacity(0.6),
            'isHighRisk': false,
          },
          {
            'time': '10:00 am',
            'title': 'Go to Hotel',
            'slot': '10:00 - 11:00 am',
            'tlColor': AppColors.fadewhite,
            'bgColor': AppColors.fadewhite.withOpacity(0.25),
            'isHighRisk': true,
          },
          {
            'time': '11:00 am',
            'title': '',
            'slot': '',
            'tlColor': AppColors.green,
            'isHighRisk': false,
          },
          {
            'time': '12:00 am',
            'title': '',
            'slot': '',
            'tlColor': AppColors.fadewhite,
            'isHighRisk': false,
          },
          {
            'time': '1:00 pm',
            'title': 'Disneyland Tour',
            'slot': '1:00 - 2:00 pm',
            'tlColor': AppColors.green,
            'bgColor': AppColors.green.withOpacity(0.6),
            'isHighRisk': true,
          },
          {
            'time': '2:00 pm',
            'title': '',
            'slot': '',
            'tlColor': AppColors.fadewhite,
            'isHighRisk': false,
          },
          {
            'time': '3:00 pm',
            'title': '',
            'slot': '',
            'tlColor': AppColors.green,
            'isHighRisk': false,
          },
        ],
      )),
    ),
    NavItem(
      id: 2,
      icon: Icon(Icons.travel_explore),
      destination: MenuScreen(),
    ),
    NavItem(
      id: 4,
      icon: Icon(Icons.account_circle),
      destination: ProfileScreen(),
    ),
  ];
}
