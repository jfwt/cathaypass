import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/covid/menu.dart';
import 'package:recipe_app/screens/subscription/carouselimage.dart';
import 'package:recipe_app/screens/subscription/plan.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key key}) : super(key: key);

  @override
  _SubscriptionPlansState createState() => _SubscriptionPlansState();
}

class _SubscriptionPlansState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        elevation: 0.0,
        title: Text('Subscription', style: TextStyle(fontWeight: FontWeight.w500),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              showDialog(context: context, builder: (context) => NotificationsPopUp());
            },
          ),
        ],
      ),*/
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          image: DecorationImage(
              image: AssetImage("assets/images/cathay.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text('Cathay Pass', style: TextStyle(fontSize: 24, color: AppColors.kTextLigntColor),),),
            SizedBox(height: 200,),
            Align(child: Text('Choose a plan', style: TextStyle(fontSize: 42, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Pangram'),), alignment: Alignment.centerLeft,),
            //CarouselImage(),
            SizedBox(height: 16,),
            Expanded(child: Container(
              child: ListView.builder(
                  itemCount: subscriptionPlanList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 1000),
                        expandedHeaderPadding: EdgeInsets.all(0),
                        elevation: 1,
                        children: [
                          ExpansionPanel(
                              headerBuilder: (context, isExpanded) {
                                return Container(
                                  height: 92,
                                  padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                                  decoration: BoxDecoration(
                                      color: subscriptionPlanList[index].color,
                                      //borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(subscriptionPlanList[index].planName,
                                              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                              "${r"$"}${subscriptionPlanList[index].price}/year",
                                              style: TextStyle(fontSize: 18, color: Colors.white))
                                        ],
                                      ),
                                      SizedBox(width: 16,),
                                      subscriptionPlanList[index].selectedPlan ? Icon(Icons.star, color: Colors.white,): Text(''),
                                    ],
                                  )
                                );
                              },
                              body: ListTile(
                                  title: Container(
                                    //padding: EdgeInsets.fromLTRB(8,0,8,8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.airplanemode_active, size: 16,),
                                            SizedBox(width: 16,),
                                            Text(subscriptionPlanList[index].trips),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.public, size: 16,),
                                            SizedBox(width: 16,),
                                            Text(subscriptionPlanList[index].destination),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.hotel, size: 16,),
                                            SizedBox(width: 16,),
                                            Text(subscriptionPlanList[index].hotelPackage),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.shield, size: 16,),
                                            SizedBox(width: 16,),
                                            Text(subscriptionPlanList[index].insurance),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          child: TextButton(
                                            onPressed: () {},
                                            child: subscriptionPlanList[index].selectedPlan ? Container(
                                              height: 36,
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: TextButton(
                                                  onPressed: () { setState(() {
                                                    subscriptionPlanList[index].selectedPlan = false;
                                                  });}, child: Text('Selected')
                                              ),
                                            ) : Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                                color: subscriptionPlanList[index].color,),
                                              height: 36,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    subscriptionPlanList[index].selectedPlan = true;
                                                  });
                                                },
                                                child: Text('Select plan', style: TextStyle(color: Colors.white),),
                                              )
                                            )),
                                          alignment: Alignment.centerRight,),
                                      ],
                                    ),
                                  ),
                                  subtitle: TextButton(
                                    child: Text("View details"),
                                    onPressed: () {},
                                  )),
                              isExpanded: subscriptionPlanList[index].expanded,
                              canTapOnHeader: true,
                          )
                        ],
                        expansionCallback: (panelIndex, isExpanded) {
                          setState(() {
                            subscriptionPlanList[index].expanded =
                            !subscriptionPlanList[index].expanded;
                          });
                        },
                      ),
                    );
                  }),
            ),),
            SizedBox(height: 8,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.kPrimaryColor),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen()));
                },
                child: Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Plan> subscriptionPlanList = <Plan>[
    Plan(
        planName: 'Basic',
        price: '9,000',
        trips: '3-day trips x 3',
        destination: 'Basic Asian destinations',
        hotelPackage: 'Basic hotel package',
        insurance: 'Standard insurance plan',
        selectedPlan: false,
        color: AppColors.kPrimaryColor),
    Plan(
        planName: 'Luxury',
        price: '11,040',
        trips: '3-day trips x 3',
        destination: 'Popular Asian destinations',
        hotelPackage: '5-star hotel package',
        insurance: 'Standard insurance plan',
        selectedPlan: false,
        color: AppColors.premiumEconClassColor),
    Plan(
        planName: 'Business',
        price: '19,200',
        trips: '4-day trips x 4',
        destination: 'Business destinations',
        hotelPackage: '5-star hotel package',
        insurance: 'Premium insurance plan',
        selectedPlan: false,
        color: AppColors.businessClassColor),
  ];
}
