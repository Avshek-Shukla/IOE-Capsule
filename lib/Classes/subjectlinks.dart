class Modelbuild {
  String title;
  String link;
  Modelbuild(this.title, this.link);
}

List<Modelbuild> linkmodel = modeldata
    .map(
      (item) => Modelbuild(
        item['title'],
        item['link'],
      ),
    )
    .toList();

var modeldata = [
  {
    "title": "Computer Engineering (BCT)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Computer%20Engineering%20(BCT)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Electronics And Communication (BEI)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Electronics%20And%20Communication%20(BEI)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Civil Engineering (BCE)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Civil%20Engineering%20(BCE)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Mechanical Engineering (BME)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Mechanical%20Engineering%20(BME)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Electrical Engineering (BEL)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Electrical%20Engineering%20(BEL)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Automobile Engineering (BAME)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Automobile%20Engineering%20(BAME)?maxRecords=1000&view=Grid%20view",
  },
  {
    "title": "Architecture (B. Arch)",
    "link":
        "https://api.airtable.com/v0/appgiINiD39DfAKzD/Architecture%20(B.%20Arch)?maxRecords=1000&view=Grid%20view",
  },
];
