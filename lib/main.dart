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
    'assets/images/drink1.png',
    'assets/images/drink2.png',
    'assets/images/drink3.png',
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

  int _currentIndex = 1;
  Color myColor = Color(0xFF36B273);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: myColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Stack(
              alignment: Alignment.topCenter,
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
                          spacing: 20,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
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
                    double scale = isSelected ? 1 : 0.5; // Enlarge center item

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
                      child: SizedBox(height: 300, width: 100),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: SizedBox(height: 300, width: 100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
