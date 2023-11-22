import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final currentIndex = 0;

  final listOfIcons = [
    Icons.home,
    Icons.favorite,
    Icons.settings,
    Icons.person
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(20),
      height: size.width * 0.155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 30,
            offset: Offset(0, 10)
          )
        ],
        borderRadius: BorderRadius.circular(50)
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == currentIndex ? 0 : size.width * 0.029,
                  right: size.width * 0.0422,
                  left: size.width * 0.0422,
                ),
                width: size.width * 0.128,
                height: index == currentIndex ? size.width * 0.014 : 0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10)
                  )
                ),
              ),
              Icon(
                listOfIcons[index],
                size: size.width * 0.076,
                color: index == currentIndex ? Colors.blueAccent : Colors.black38,
              ),
              SizedBox(height: size.width * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}