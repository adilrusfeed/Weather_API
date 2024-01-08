// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_api/services/location_provider.dart';
 
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).determinePosition();
    super.initState();
  }

  bool _clicked = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 65, bottom: 20, left: 20, right: 20),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/img/clouds.jpg"))),
        child: Stack(
          children: [
            _clicked == true
                ? Positioned(
                    top: 60,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 45,
                      child: TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dubai",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Text(
                              "Dubai",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        size: 40,
                      ))
                ],
              ),
            ),
            Align(
                alignment: Alignment(0, -0.65),
                child: Image.asset("assets/img/sun.png")),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 130,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "21°C",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Cloudy",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      DateTime.now().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.9, 0.75),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.4)),
                  height: 180,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/temperature-high.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp Max",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("21°C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/temperature-low.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp min",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("21°C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          indent: 25,
                          endIndent: 33,
                          thickness: 3,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/sun.png",
                                  height: 55,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp Max",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("21°C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/img/moon.png",
                                  height: 40,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Temp min",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("21°C",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ])),
            )
          ],
        ),
      ),
    );
  }
}
