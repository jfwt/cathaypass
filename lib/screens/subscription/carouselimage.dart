import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({Key key}) : super(key: key);

  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int activeIndex = 0;
  List<String> welcomeImagesUrl = [
    'assets/images/tokyo.jpg',
    'assets/images/seoul.jpg',
    'assets/images/busan.jpg',
    'assets/images/busan.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1,
            autoPlay: true,
            // autoPlayInterval: Duration(seconds: 2),
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
          itemCount: welcomeImagesUrl.length,
          itemBuilder: (context, index, realIndex) {
            final image = AssetImage(welcomeImagesUrl[index]);
            return Column(
              children: [
                Image(image: image, height: 160, width: 240, fit: BoxFit.cover,),
                Container(height: 16,),
                Text(['Enjoy 3+ trips at one price', 'Travel at anytime', 'AI Trip Planner', 'Disruption Management'][index],),
              ],
            );
          },
        ),
        SizedBox(height: 4,),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: welcomeImagesUrl.length,
    effect: ExpandingDotsEffect(
        activeDotColor: AppColors.kPrimaryColor,
        dotHeight: 8,
        dotWidth: 8
    ),
  );
}
