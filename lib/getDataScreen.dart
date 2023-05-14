import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projectioe/Classes/getyearpartclass.dart';
import 'package:projectioe/Classes/subjectlinks.dart';
import 'package:projectioe/pdfviewScreen.dart';

//import 'package:http/http.dart' as http;

class Getdata extends StatefulWidget {
  final String title;
  final String subject;
  final String img;
  Getdata({Key key, @required this.title, this.subject, this.img})
      : super(key: key);

  @override
  _GetdataState createState() => _GetdataState(title, subject, img);
}

class _GetdataState extends State<Getdata> with SingleTickerProviderStateMixin {
  String title;
  String subject;
  String img;

  _GetdataState(this.title, this.subject, this.img);

  List records;
  Future<void> fetch() async {
    String url = linkmodel[
            linkmodel.indexWhere((linkmodel) => linkmodel.title == subject)]
        .link;
    Map<String, String> header = {"Authorization": "Bearer keyBv8irb0stS6ugH"};
    http.Response res = await http.get(Uri.parse(url), headers: header);
    Map<String, dynamic> result = jsonDecode(res.body);
    records = result['records'];
    setState(() {});
    return;
  }

  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _controller.forward();
    Future.microtask(() async => this.fetch());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
                    this.title,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25.0,
                        color: Colors.black,
                        fontFamily: "Exo2"),
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
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Color.fromRGBO(242, 188, 148, 1),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(this.img))),
                ),
                SizedBox(width: 6),
                this.subject.contains("Electronics")
                    ? Expanded(
                        flex: this.subject.length - 10,
                        child: Text(
                          this.subject,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(
                        this.subject,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Color.fromRGBO(242, 188, 148, 1),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                records == null
                    ? Row(
                        children: [
                          Text(
                            "Fetching Data...",
                            style: TextStyle(
                                fontSize: 19, fontFamily: "Quicksand"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AnimatedBuilder(
                              animation: _controller.view,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: -_controller.value * 4 * -pi,
                                  child: Text(
                                    "/",
                                    style: TextStyle(
                                        fontSize: 24, fontFamily: "Quicksand"),
                                  ),
                                );
                              })
                        ],
                      )
                    : Text(
                        " Select Year/Part",
                        style: TextStyle(fontSize: 19, fontFamily: "Quicksand"),
                      ),
                SizedBox(
                  height: 1,
                ),
                Container(
                  height: 2,
                  color: Color.fromRGBO(242, 188, 148, 1),
                )
              ],
            ),
            records == null
                ? Expanded(
                    child: Container(
                      child: Lottie.asset("assets/images/fetching.json"),
                    ),
                  )
                : Expanded(
                    child: Container(
                        child: ListView.builder(
                            itemCount: yearpart.length,
                            itemBuilder: (context, outloop) {
                              return Column(
                                children: [
                                  ListTileTheme(
                                    dense: true,
                                    child: ExpansionTile(
                                      leading:
                                          Icon(Icons.account_tree_outlined),
                                      tilePadding: EdgeInsets.only(left: 10),
                                      title: Row(
                                        children: [
                                          Text(
                                            yearpart[outloop].title,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: "SourceSansPro",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        Column(children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: this.records.length,
                                              itemBuilder: (contex, index) {
                                                return this
                                                            .records[index]
                                                                ['fields'][
                                                                yearpart[
                                                                        outloop]
                                                                    .title]
                                                            .toString() ==
                                                        "NULL"
                                                    ? null
                                                    : Column(
                                                        children: [
                                                          Container(
                                                            height: 1,
                                                            width:
                                                                size.width - 20,
                                                            color:
                                                                Color.fromRGBO(
                                                                    238,
                                                                    238,
                                                                    238,
                                                                    1),
                                                          ),
                                                          SizedBox(
                                                            height: 13,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              print("tapped");
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return PdfViewer(
                                                                  title: this
                                                                      .title,
                                                                  subjectname: this
                                                                      .records[
                                                                          index]
                                                                          [
                                                                          'fields']
                                                                          [
                                                                          yearpart[outloop]
                                                                              .title]
                                                                      .toString(),
                                                                );
                                                              }));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(
                                                                          image:
                                                                              NetworkImage("https://res.cloudinary.com/dqbmrgt4y/image/upload/v1616837231/child_icon_oxh0nl.png"))),
                                                                ),
                                                                SizedBox(
                                                                  width: 7,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    this
                                                                        .records[
                                                                            index]
                                                                            [
                                                                            'fields']
                                                                            [
                                                                            yearpart[outloop].title]
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14.0),
                                                                  ),
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.end,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_forward)
                                                                    ]),
                                                                SizedBox(
                                                                  width: 10,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 13.0,
                                                          ),
                                                        ],
                                                      );
                                              }),
                                        ])
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: 0,
                                    indent: 0,
                                    endIndent: 20,
                                    // color: Colors.white30,
                                  ),
                                ],
                              );
                            })),
                  ),
          ],
        ),
      ),
    ));
  }
}
