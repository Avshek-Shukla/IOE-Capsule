import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:projectioe/Classes/pdflinks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:projectioe/Classes/subjectlinks.dart';

class PdfViewer extends StatefulWidget {
  final String title;
  final String subjectname;
  PdfViewer({Key key, @required this.title, this.subjectname})
      : super(key: key);
  @override
  _PdfViewerState createState() => _PdfViewerState(title, subjectname);
}

class _PdfViewerState extends State<PdfViewer> {
  List records;
  String title;
  String subjectname;
  _PdfViewerState(this.title, this.subjectname);

  Future<void> fetch() async {
    //print(records);
    String url =
        linkmodel[linkmodel.indexWhere((linkmodel) => linkmodel.title == title)]
            .link;
    print(title);
    print(url);
    Map<String, String> header = {"Authorization": "Bearer keyBv8irb0stS6ugH"};
    http.Response res = await http.get(Uri.parse(url), headers: header);
    Map<String, dynamic> result = jsonDecode(res.body);
    records = result['records'];
    setState(() {});
    return;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => this.fetch());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 54,
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        print("Tapped Back");
                      },
                      child: const Icon(
                        MdiIcons.keyboardBackspace,
                        size: 30,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                      child: Material(
                    color: Colors.black,
                    child: Text(
                      this.title + " : " + this.subjectname,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Exo2",
                          color: Colors.white),
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            records == null
                ? Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Lottie.asset("assets/images/fetching.json"),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: WebviewScaffold(
                        initialChild: Container(
                          child: Center(
                            child: Lottie.asset("assets/images/fetching.json"),
                          ),
                        ),
                        url: this
                            .records[this.records.indexWhere((records) =>
                                records['fields']['Subject'] ==
                                subjectname)]['fields']['PDF']
                            .toString(),
                        withJavascript: true,
                        scrollBar: true,
                        withZoom: true,
                        displayZoomControls: true,
                        bottomNavigationBar: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                onPressed: () {},
                                child: Icon(FontAwesomeIcons.download),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
