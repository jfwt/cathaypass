import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/NavItem.dart';
import 'package:recipe_app/models/task.dart';
import 'package:recipe_app/screens/covid/menu.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'package:recipe_app/screens/subscription/subscriptionpage.dart';
import 'package:recipe_app/widgets/calendarpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Task task = Task(
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
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cathay Pass',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: AppColors.primarySwatch,
          fontFamily: 'OpenSans',
          // We apply this to our appBarTheme because most of our appBar have this style
          appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white), backgroundColor: AppColors.kPrimaryColor, elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: MenuScreen(),
        // home: SubscriptionPage(),
        home: CalendarPage(task),
      ),
    );
  }
}
