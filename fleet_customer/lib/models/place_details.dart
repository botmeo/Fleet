import 'dart:convert';

class PlaceDetails {
  Result result;

  PlaceDetails({
    this.result,
  });

  PlaceDetails.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() => {
        'result': result.toJson(),
      };

  static PlaceDetails parsePlaceDetailsResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceDetails.fromJson(parsed);
  }
}

class Result {
  List<AddressComponents> addressComponents;
  String adrAddress;
  String businessStatus;
  CurrentOpeningHours currentOpeningHours;
  String formattedAddress;
  String formattedPhoneNumber;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String internationalPhoneNumber;
  String name;
  CurrentOpeningHours openingHours;
  List<Photos> photos;
  String placeId;
  PlusCode plusCode;
  // double rating;
  String reference;
  List<Reviews> reviews;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;
  bool wheelchairAccessibleEntrance;

  Result({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.currentOpeningHours,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    // this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
    this.wheelchairAccessibleEntrance,
  });

  Result.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents.add(new AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    businessStatus = json['business_status'];
    currentOpeningHours = json['current_opening_hours'] != null
        ? new CurrentOpeningHours.fromJson(json['current_opening_hours'])
        : null;
    formattedAddress = json['formatted_address'];
    formattedPhoneNumber = json['formatted_phone_number'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    internationalPhoneNumber = json['international_phone_number'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? new CurrentOpeningHours.fromJson(json['opening_hours'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    // rating = json['rating'];
    reference = json['reference'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
    url = json['url'];
    userRatingsTotal = json['user_ratings_total'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
    website = json['website'];
    wheelchairAccessibleEntrance = json['wheelchair_accessible_entrance'];
  }

  Map<String, dynamic> toJson() => {
        'address_components': addressComponents.map((v) => v.toJson()).toList(),
        'adr_address': adrAddress,
        'business_status': businessStatus,
        'current_opening_hours': currentOpeningHours.toJson(),
        'formatted_address': formattedAddress,
        'formatted_phone_number': formattedPhoneNumber,
        'geometry': geometry.toJson(),
        'icon': icon,
        'icon_background_color': iconBackgroundColor,
        'icon_mask_base_uri': iconMaskBaseUri,
        'international_phone_number': internationalPhoneNumber,
        'name': name,
        'opening_hours': openingHours.toJson(),
        'photos': photos.map((v) => v.toJson()).toList(),
        'place_id': placeId,
        'plus_code': plusCode.toJson(),
        // 'rating': rating,
        'reference': reference,
        'reviews': reviews.map((v) => v.toJson()).toList(),
        'types': types,
        'url': url,
        'user_ratings_total': userRatingsTotal,
        'utc_offset': utcOffset,
        'vicinity': vicinity,
        'website': website,
        'wheelchair_accessible_entrance': wheelchairAccessibleEntrance,
      };
}

class AddressComponents {
  String longName;
  String shortName;
  List<String> types;

  AddressComponents({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'long_name': longName,
        'short_name': shortName,
        'types': types,
      };
}

class CurrentOpeningHours {
  bool openNow;
  List<Periods> periods;
  List<String> weekdayText;

  CurrentOpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  CurrentOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods.add(new Periods.fromJson(v));
      });
    }
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'open_now': openNow,
        'periods': periods.map((v) => v.toJson()).toList(),
        'weekday_text': this.weekdayText,
      };
}

class Periods {
  Close close;
  Close open;

  Periods({
    this.close,
    this.open,
  });

  Periods.fromJson(Map<String, dynamic> json) {
    close = json['close'] != null ? new Close.fromJson(json['close']) : null;
    open = json['open'] != null ? new Close.fromJson(json['open']) : null;
  }

  Map<String, dynamic> toJson() => {
        'close': close.toJson(),
        'open': open.toJson(),
      };
}

class Close {
  String date;
  int day;
  String time;

  Close({
    this.date,
    this.day,
    this.time,
  });

  Close.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() => {
        'date': date,
        'day': day,
        'time': time,
      };
}

class Geometry {
  Location location;
  Viewport viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'viewport': viewport.toJson(),
      };
}

class Location {
  double lat;
  double lng;

  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };
}

class Viewport {
  Location northeast;
  Location southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() => {
        'northeast': northeast.toJson(),
        'southwest': southwest.toJson(),
      };
}

class Photos {
  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  Photos({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() => {
        'height': height,
        'html_attributions': htmlAttributions,
        'photo_reference': photoReference,
        'width': width,
      };
}

class PlusCode {
  String compoundCode;
  String globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() => {
        'compound_code': compoundCode,
        'global_code': globalCode,
      };
}

class Reviews {
  String authorName;
  String authorUrl;
  String language;
  String originalLanguage;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;
  bool translated;

  Reviews({
    this.authorName,
    this.authorUrl,
    this.language,
    this.originalLanguage,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
    this.translated,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    originalLanguage = json['original_language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'];
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
    translated = json['translated'];
  }

  Map<String, dynamic> toJson() => {
        'author_name': authorName,
        'author_url': authorUrl,
        'language': language,
        'original_language': originalLanguage,
        'profile_photo_url': profilePhotoUrl,
        'rating': rating,
        'relative_time_description': relativeTimeDescription,
        'text': text,
        'time': time,
        'translated': translated,
      };
}
