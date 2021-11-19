import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/subscription/subscriptionpage.dart';
import 'package:recipe_app/size_config.dart';

import 'info.dart';
import 'profile_menu_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        _buildProfileHeader(screenHeight),
        _buildProfileBody(screenHeight, context),
      ],
    );
      /*SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Info(
            image: "assets/images/pic.png",
            name: "YouTuber Andrew",
            // email: "youtuberaf@gmail.com",
          ),
          Container(
            margin: EdgeInsets.only(left: SizeConfig.defaultSize * 2),
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 2, //20
              vertical: SizeConfig.defaultSize * 0.5, //5
            ),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(
                SizeConfig.defaultSize * 1.6, // 16
              ),
            ),
            child: Text(
              'Luxury',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.defaultSize * 2), //20
          ProfileMenuItem(
            iconSrc: "assets/icons/chef_nav.svg",
            title: "Preferences",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/bookmark_fill.svg",
            title: "Subscription Plan",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriptionPage(),
                ),
              );
            },
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/language.svg",
            title: "Change Language",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Help",
            press: () {},
          ),
        ],
      ),
    );*/
  }

  SliverToBoxAdapter _buildProfileHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            height: 64,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  height: 128,
                  width: 128,
                  child: ClipOval(
                      child: Image.asset("assets/images/pic.png", fit: BoxFit.cover,)
                  ),
                ),
                SizedBox(height: 16,),
                Text('Fung Dean', style: TextStyle(fontSize: 32, fontFamily: 'Pangram'),),
                SizedBox(height: 16,),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.premiumEconClassColor),
                  padding: EdgeInsets.symmetric(vertical: 4,horizontal: 32),
                  child: Text('Luxury', style: TextStyle(fontSize: 18, color: AppColors.white, fontFamily: 'Pangram'),)
                ),
                SizedBox(height: 32,)
              ],
            )
          )
        ],
      )
    );
  }

  SliverToBoxAdapter _buildProfileBody(double screenHeight, context) {
    return SliverToBoxAdapter(
      child: Container(
          color: Color(0xFF9BC1BC).withOpacity(0.9),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white,),
                    SizedBox(width: 32,),
                    Text('View your trip record', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                    Expanded(child: SizedBox(width: 32,)),
                    Icon(Icons.arrow_forward_ios, size: 16,color: Colors.white,),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubscriptionPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFF085D63).withOpacity(0.3)),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Icon(Icons.fact_check_outlined, color: Colors.white,),
                      SizedBox(width: 32,),
                      Text('Change your subscription plan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      Expanded(child: SizedBox(width: 32,)),
                      Icon(Icons.arrow_forward_ios, size: 16,color: Colors.white,),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.white,),
                    SizedBox(width: 32,),
                    Text('Trip suggestion', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                    Expanded(child: SizedBox(width: 32,)),
                    Icon(Icons.arrow_forward_ios, size: 16,color: Colors.white,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.warning_rounded, color: Colors.white,),
                    SizedBox(width: 32,),
                    Text('COVID updates', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                    Expanded(child: SizedBox(width: 32,)),
                    Icon(Icons.arrow_forward_ios, size: 16,color: Colors.white,),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.help, color: Colors.white,),
                    SizedBox(width: 32,),
                    Text('Help', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                    Expanded(child: SizedBox(width: 32,)),
                    Icon(Icons.arrow_forward_ios, size: 16,color: Colors.white,),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
