abstract class Location {
  double latitude;
  double longitude;

  double getLatitude();
  double getLongitude();
}

class LocationData extends Location {
  double getLatitude() {
    return latitude;
  }

  double getLongitude() {
    return longitude;
  }

  Map<String,dynamic> toJson() => {
    'latitude' : latitude,
    'longitude' : longitude
  };
}

class FacebookLocationData extends LocationData {
  FacebookLocationData();

  FacebookLocationData.fromJson(Map<String, dynamic> locationJson) {
    latitude = locationJson['latitude'];
    longitude = locationJson['longitude'];
  }
}

class TwitterLocationData extends LocationData {
  TwitterLocationData();

  TwitterLocationData.fromJson(Map<String, dynamic> json) {
    // one has to contain values since we test for nullable of both in api_requests
    if(json['coordinates'] != null) TwitterLocationData.fromJsonCoordinates(json['coordinates']);
    else TwitterLocationData.fromJsonPlace(json['place']);
  }
  /// when the Tweet has an exact location point
  TwitterLocationData.fromJsonCoordinates(Map<String, dynamic> locationJson) {
    // locationJson looks like {"type" : String, "coordinates" : [double, double]}
    // coordinates array stores as [longitude, latitude]
    latitude = locationJson['coordinates'][1];
    longitude = locationJson['coordinates'][0];
  }

  /// when a place is associated with a Tweet
  TwitterLocationData.fromJsonPlace(Map<String, dynamic> locationJson) {
    // locationJson looks like
    // { ... , "bounding_box" : { "type": "Polygon", "coordinates" : [[[long,lat],[long,lat],[long,lat],[long,lat]]], ...}

    double x1, x2, y1, y2;
    List<List> coords = locationJson['bounding_box']['coordinates'][0];
    x1 = coords[0][1]; x2 = coords[0][1]; y1 = coords[0][0]; y2 = coords[0][0];

    for(int i=1; i<coords.length; i++) {
      double x = coords[i][1]; double y = coords[i][0];
      if(x<x1) x1 = x;
      if(x>x2) x2 = x;
      if(x<y1) y1 = y;
      if(y>y2) y2 = y;
    }
    // returns the center of the bounding rectangle of the bounding box polygon
    latitude = x1 + ((x2 - x1)/2);
    longitude = y1 + ((y2 - y1)/2);
  }

  //use
  //place : json['coordinates'] == null ? (json['place'] == null ? null : TwitterLocationData.fromJsonPlace(json['place'])) : TwitterLocationData.fromJsonCoordinates(json['coordinates']),
}