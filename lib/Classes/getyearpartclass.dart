class Modelbuild {
  String title;
  Modelbuild(this.title);
}

List<Modelbuild> yearpart = modeldata
    .map(
      (item) => Modelbuild(
        item['title'],
      ),
    )
    .toList();

var modeldata = [
  {
    "title": "First Year-First Part",
  },
  {
    "title": "First Year-Second Part",
  },
  {
    "title": "Second Year-First Part",
  },
  {
    "title": "Second Year-Second Part",
  },
  {
    "title": "Third Year-First Part",
  },
  {
    "title": "Third Year-Second Part",
  },
  {
    "title": "Fourth Year-First Part",
  },
  {
    "title": "Fourth Year-Second Part",
  },
];
