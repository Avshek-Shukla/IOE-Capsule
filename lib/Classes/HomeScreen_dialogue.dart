import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:projectioe/getDataScreen.dart';

class DialogueBar extends StatefulWidget {
  final String title;
  DialogueBar({Key key, @required this.title}) : super(key: key);
  @override
  _DialogueBarState createState() => _DialogueBarState(title);
}

class _DialogueBarState extends State<DialogueBar> {
  String title;
  String img;
  _DialogueBarState(this.title);
  List records;
  Future<void> fetch() async {
    String url =
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/SUBLIST?maxRecords=1000&view=Grid%20view";
    Map<String, String> header = {"Authorization": "Bearer keyBv8irb0stS6ugH"};
    http.Response res = await http.get(Uri.parse(url), headers: header);
    Map<String, dynamic> result = jsonDecode(res.body);
    records = result['records'];
    setState(() {});
    return;
  }

  @override
  void initState() {
    Future.microtask(() async => this.fetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
      content: Container(
        height: size.height * 0.615,
        width: size.width,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Choose Department...",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Quicksand"),
                  ),
                ),
                SizedBox(
                  height: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
            records == null
                ? Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: Lottie.asset("assets/images/subload.json")),
                  )
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                      itemCount: this.records.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Getdata(
                                title: this.title,
                                subject: this
                                    .records[index]['fields']['Subject List']
                                    .toString(),
                                img: this
                                    .records[index]['fields']['ICON']
                                    .toString(),
                              );
                            }));
                            print(this
                                .records[index]['fields']['Subject List']
                                .toString());
                          },
                          child: Container(
                            height: 35,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(this
                                              .records[index]['fields']['ICON']
                                              .toString()))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          this
                                              .records[index]['fields']
                                                  ['Subject List']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "Roboto Regular",
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 20.0,
                                  width: 20.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://res.cloudinary.com/dqbmrgt4y/image/upload/v1620725910/extraicon_1_y2j7qd.png"))),
                                ),
                                SizedBox(
                                  width: 12,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
