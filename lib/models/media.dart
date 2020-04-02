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

class TwitterMedia extends Media {
  Map<String, Map<String, dynamic>> sizes;

  TwitterMedia.fromJson(Map<String, dynamic> json) {
    this.type = json['type'];
    this.url = json['media_url'];
    this.sizes = {
      'medium': {
        'w': json['sizes']['medium']['w'],
        'h': json['sizes']['medium']['h'],
        'resize': json['sizes']['medium']['resize']
      },
      'small': {
        'w': json['sizes']['small']['w'],
        'h': json['sizes']['small']['h'],
        'resize': json['sizes']['small']['resize']
      },
      'thumb': {
        'w': json['sizes']['thumb']['w'],
        'h': json['sizes']['thumb']['h'],
        'resize': json['sizes']['thumb']['resize']
      },
      'large': {
        'w': json['sizes']['large']['w'],
        'h': json['sizes']['large']['h'],
        'resize': json['sizes']['large']['resize']
      }
    };
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
