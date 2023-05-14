import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectioe/Classes/containerbuilder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity/connectivity.dart';
import 'package:projectioe/Classes/HomeScreen_dialogue.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectionstatus;
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      print(_connectionstatus);
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        this.fetch();
      }
      setState(() {
        _connectionstatus = result;
      });
    });
  }

  String title;
  List records;
  Future<void> fetch() async {
    //print(records);
    String url =
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Slider?maxRecords=1000&view=Grid%20view";
    Map<String, String> header = {"Authorization": "Bearer keyBv8irb0stS6ugH"};
    http.Response res = await http.get(Uri.parse(url), headers: header);
    Map<String, dynamic> result = jsonDecode(res.body);
    records = result['records'];
    setState(() {});
    return;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Column(
            children: [
              Container(
                transformAlignment: Alignment.topCenter,
                height: 53,
                alignment: Alignment.topLeft,
                color: Colors.white,
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Back Pressed");
                      },
                      child: const Icon(
                        MdiIcons.keyboardBackspace,
                        color: Colors.black,
                        size: 35.0,
                      ),
                    ),
                    Text(
                      "HOME",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 25.0,
                          color: Colors.black,
                          fontFamily: "virgo"),
                      textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                        onTap: () {
                          print("i clicked");
                        },
                        child: const Icon(
                          FontAwesomeIcons.infoCircle,
                          size: 32.0,
                        )),
                  ],
                ),
              ),
              (_connectionstatus == ConnectivityResult.none)
                  ? Expanded(
                      child: Container(
                      color: Colors.white,
                      child: Lottie.asset("assets/images/no_connection.json"),
                    ))
                  : ((records == null &&
                          _connectionstatus != ConnectivityResult.none)
                      ? Expanded(
                          child: Container(
                          color: Colors.white,
                          child: Lottie.asset("assets/images/loading.json"),
                        ))
                      : Expanded(
                          child: Column(
                            children: [
                              Container(
                                  height: size.height * 0.3,
                                  width: size.width * 0.98,
                                  child: CarouselSlider.builder(
                                    slideBuilder: (index) {
                                      return Container(
                                        height: size.height * 0.2,
                                        width: size.width * 0.98,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: DecorationImage(
                                                image: NetworkImage(this
                                                    .records[index]['fields']
                                                        ['URL']
                                                    .toString()),
                                                fit: BoxFit.fill)),
                                      );
                                    },
                                    itemCount: this.records.length,
                                    enableAutoSlider: true,
                                    autoSliderDelay: Duration(seconds: 4),
                                    unlimitedMode: true,
                                    slideTransform: CubeTransform(),
                                    slideIndicator: CircularSlideIndicator(
                                      indicatorRadius: 3.6,
                                      indicatorBackgroundColor:
                                          Color.fromRGBO(136, 136, 136, 1.0),
                                      itemSpacing: 11,
                                      currentIndicatorColor:
                                          Color.fromRGBO(245, 8, 112, 1.0),
                                      padding: EdgeInsets.only(bottom: 6),
                                    ),
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "OPTIONS",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 21.0,
                                          color: Colors.black,
                                          fontFamily: "Exo2",
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 4,
                                          width: 4,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  244, 175, 27, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        Text(
                                          "For Enrolled Students",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 13.0,
                                              color: Color.fromRGBO(
                                                  244, 175, 27, 1),
                                              fontFamily: "Exo2",
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 2,
                                width: 0.92 * size.width,
                                color: Color.fromRGBO(244, 175, 27, 1),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: model.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            title = model[index].title;
                                            print(title);
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return DialogueBar(
                                                      title: title);
                                                });
                                          },
                                          child: Card(
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.all(8.0),
                                                    height: 85,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          255, 105, 180, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: model[index].img,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          model[index].title,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Roboto Regular",
                                                              fontSize: 20.0,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2.0,
                                                                  bottom: 2.0,
                                                                  right: 2.0,
                                                                  left: 4.0),
                                                          child: Text(
                                                            model[index]
                                                                .subtitle,
                                                            maxLines: 2,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Roboto Regular",
                                                                fontSize: 12.0,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        158,
                                                                        158,
                                                                        158,
                                                                        1)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
