import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageCarouselScreen(),
    );
  }
}

class ImageCarouselScreen extends StatefulWidget {
  const ImageCarouselScreen({super.key});

  @override
  _ImageCarouselScreenState createState() => _ImageCarouselScreenState();
}

class _ImageCarouselScreenState extends State<ImageCarouselScreen> {
  CarouselSliderController? carouselController = CarouselSliderController();
  final List<String> imagePaths = [
    'assets/dd1.png',
    'assets/ss2.png',
    'assets/ss3.png',
  ];
  final List<Map<String, String>> details = [
    {
      "price": "35",
      "title": "Vennila",
      "desc":
          "Anim incididunt anim excepteur aliquip. Ex irure ut aute anim laboris excepteur dolore. Eiusmod ullamco magna duis ullamco dolore. Commodo amet dolor dolor dolore ipsum labore est.",
    },
    {
      "price": "30",
      "title": "Choco shake",
      "desc":
          "Adipisicing voluptate deserunt veniam qui ex exercitation cillum aliqua proident veniam. Anim irure dolor amet mollit proident voluptate elit quis. Incididunt labore veniam minim veniam sint.",
    },
    {
      "price": "40",
      "title": "Fruit Mixer",
      "desc":
          "Ipsum magna sit cillum nulla commodo sint non labore in consectetur eu aliqua. Qui irure Lorem duis adipisicing proident duis ipsum. Voluptate nulla sit enim amet aliqua aliqua commodo aliquip ex velit cillum qui est est.",
    },
  ];

  int _currentIndex = 0;
  Color myColor = Color(0xFF36B273);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: myColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              padding: EdgeInsets.all(20),
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-3, 10),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CarouselSlider.builder(
                carouselController: carouselController!,
                options: CarouselOptions(
                  scrollDirection: Axis.vertical,
                  enlargeFactor: 1,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                      carouselController!.animateToPage(index);
                    });
                  },
                ),
                itemCount: details.length,
                itemBuilder: (context, index, realIndex) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0),
                      Text(
                        "\$ ${details[index]['price']!}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        details[index]['title']!,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        details[index]['desc']!,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.black,
                          elevation: 5, // elevation
                        ),
                        onPressed: () {},
                        child: Text(
                          "Get it!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          CarouselSlider.builder(
            carouselController: carouselController!,
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              viewportFraction: 0.45,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                  carouselController!.animateToPage(index);
                });
              },
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index, realIndex) {
              bool isSelected = index == _currentIndex;
              double scale = isSelected ? 1 : 0.8; // Enlarge center item

              return TweenAnimationBuilder(
                duration: Duration(milliseconds: 300),
                tween: Tween<double>(begin: scale, end: scale),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Image.asset(
                      imagePaths[index],
                      fit: BoxFit.fitHeight,
                      width: double.infinity,
                    ),
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(height: 330, width: 100),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SizedBox(height: 330, width: 100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
