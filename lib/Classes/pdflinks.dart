class Modelbuild {
  String title;
  String link;
  Modelbuild(this.title, this.link);
}

List<Modelbuild> pdflink = modeldata
    .map(
      (item) => Modelbuild(
        item['title'],
        item['link'],
      ),
    )
    .toList();

var modeldata = [
  {
    "title": "Notes",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Notes?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Syllabus",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Syllabus?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Old Questions",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Old%20Questions?maxRecords=3&view=Grid%20view",
  },
];
