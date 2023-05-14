import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Modelbuild {
  String title;
  String subtitle;
  Widget img;
  Modelbuild(this.title, this.subtitle, this.img);
}

List<Modelbuild> model = modeldata
    .map(
      (item) => Modelbuild(
        item['title'],
        item['subtitle'],
        item['img'],
      ),
    )
    .toList();

var modeldata = [
  {
    "title": "Notes",
    "subtitle": "Notes of all Subject of all Year/Part.",
    "img": Icon(
      FontAwesomeIcons.bookOpen,
      size: 48.0,
      color: Colors.white,
    ),
  },
  {
    "title": "Syllabus",
    "subtitle": "All Subjects of all Departs by Year/Part.",
    "img": Icon(
      FontAwesomeIcons.graduationCap,
      size: 48.0,
      color: Colors.white,
    ),
  },
  {
    "title": "Old Questions",
    "subtitle": "By Departments Divided in Year/Part.",
    "img": Icon(
      FontAwesomeIcons.question,
      size: 55.0,
      color: Colors.white,
    ),
  }
];
