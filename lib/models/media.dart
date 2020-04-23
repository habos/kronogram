class Media {
  String type;
  String url;
}

class InstaMedia extends Media {
  InstaMedia(String type, String url) {
    this.type = type;
    this.url = url;
  }
}

class FacebookMedia extends Media {
  //type can be cover_photo, profile_media, photo, probably video too but not tested
  Map<String, int> size;
  FacebookMedia.fromJson(Map<String, dynamic> json) {
    this.type = json['type'];
    this.url = json['media']['image']['src'];
    this.size = {
      'height': json['media']['image']['height'],
      'width': json['media']['image']['width']
    };
  }

  String getUrl() {
    return this.url;
  }
}
