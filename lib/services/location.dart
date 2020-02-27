class Location {
  String country;
  String countryCode;
}

class TwitterLocation extends Location{
  String fullName;
//  List<Map<String,String>> coordinates;     FIXME: could have different amounts of coordinates depending on shape

  TwitterLocation.fromJson(Map<String,dynamic> json) {
    this.country = json['country'];
    this.countryCode = json['country_code'];
    this.fullName = json['full_name'];
//    var coordsList = json['coordinates'][0];
//    for(int i=0; i<4; i++) {
//      coordinates.add({''})coordsList[i][0]
//    }
  }
}
