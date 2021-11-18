import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';

class Task {
  final Icon iconData;
  final String title;
  final Color bgColor;
  final Color iconColor;
  final Color btnColor;
  final num left;
  final num done;
  final List<Map<String, dynamic>> desc;
  final bool isLast;
  Task({
    this.iconData,
    this.title,
    this.bgColor,
    this.btnColor,
    this.done,
    this.iconColor,
    this.left,
    this.desc,
    this.isLast = false,
  });
  static List<Task> generateTasks() {
    return [
      Task(
          iconData: Icon(Icons.person_rounded),
          title: 'Personal',
          bgColor: Colors.yellow,
          iconColor: Colors.orange,
          btnColor: Colors.pink,
          left: 3,
          done: 1,
          desc: [
            {
              'time': '9:00 am',
              'title': 'Arrive at Airport',
              'slot': '9:00 - 10:00 am',
              'tlColor': Colors.green,
              'bgColor': Colors.blue,
            },
            {
              'time': '10:00 am',
              'title': 'Go to Hotel',
              'slot': '10:00 - 11:00 am',
              'tlColor': Colors.red,
              'bgColor': Colors.blue,
            },
            {
              'time': '11:00 am',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
              'bgColor': Colors.grey.withOpacity(0.3),
            }
          ]),
      Task(
          iconData: Icon(Icons.cases_rounded),
          title: 'Personal',
          bgColor: Colors.yellow,
          iconColor: Colors.orange,
          btnColor: Colors.pink,
          left: 3,
          done: 1,
          desc: [
            {
              'time': '9:00 am',
              'title': 'Arrive at Airport',
              'slot': '9:00 - 10:00 am',
              'tlColor': Colors.green,
              'bgColor': Colors.blue,
            },
            {
              'time': '10:00 am',
              'title': 'Go to Hotel',
              'slot': '10:00 - 11:00 am',
              'tlColor': Colors.red,
              'bgColor': Colors.blue,
            },
            {
              'time': '11:00 am',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
              'bgColor': Colors.grey.withOpacity(0.3),
            },
            {
              'time': '11:00 - 12:00pm',
              'title': '',
              'slot': '',
              'tlColor': Colors.orange,
              'bgColor': Colors.purple,
            }
          ]),
    ];
  }
}
