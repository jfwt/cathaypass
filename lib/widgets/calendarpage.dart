import 'package:flutter/material.dart';
import 'package:recipe_app/components/my_bottom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/task.dart';
import 'package:recipe_app/widgets/datepicker.dart';
import 'package:recipe_app/widgets/tasktimeline.dart';

class CalendarPage extends StatelessWidget {
  final Task task;
  CalendarPage(this.task);
  @override
  Widget build(BuildContext context) {
    final detailList = task.desc;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DatePicker(),
                ],
              ),
            ),
          ),
          detailList == null
              ? SliverFillRemaining(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'No task today',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ),
          )
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, index) => TaskTimeline(detailList[index]),
              childCount: detailList.length,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: MyBottomNavBar(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 90,
      backgroundColor: AppColors.green,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios),
        iconSize: 20,
      ),
      actions: [
        Icon(
          Icons.more_vert,
          size: 40,
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Text(
                'Trip Planner',
                style: TextStyle(
                  fontFamily: 'Pangram',
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
