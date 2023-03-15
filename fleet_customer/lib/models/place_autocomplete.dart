import 'dart:convert';

class PlaceAutoComplete {
  List<Predictions> predictions;

  PlaceAutoComplete({
    this.predictions,
  });

  PlaceAutoComplete.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        'predictions': predictions.map((v) => v.toJson()).toList(),
      };

  static PlaceAutoComplete parseAutocompleteResult(String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();
    return PlaceAutoComplete.fromJson(parsed);
  }
}

class Predictions {
  String description;
  List<MatchedSubstrings> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Terms> terms;
  List<String> types;

  Predictions({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    if (json['matched_substrings'] != null) {
      matchedSubstrings = <MatchedSubstrings>[];
      json['matched_substrings'].forEach((v) {
        matchedSubstrings.add(new MatchedSubstrings.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? new StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms.add(new Terms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
        'description': description,
        'matched_substrings': matchedSubstrings.map((v) => v.toJson()).toList(),
        'place_id': placeId,
        'reference': reference,
        'structured_formatting': structuredFormatting.toJson(),
        'terms': terms.map((v) => v.toJson()).toList(),
        'types': types,
      };
}

class MatchedSubstrings {
  int length;
  int offset;

  MatchedSubstrings({
    this.length,
    this.offset,
  });

  MatchedSubstrings.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'offset': offset,
      };
}

class StructuredFormatting {
  String mainText;
  // List<MainTextMatchedSubstrings> mainTextMatchedSubstrings;
  String secondaryText;

  StructuredFormatting({
    this.mainText,
    // this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    // if (json['main_text_matched_substrings'] != null) {
    //   mainTextMatchedSubstrings = <MainTextMatchedSubstrings>[];
    //   json['main_text_matched_substrings'].forEach((v) {
    //     mainTextMatchedSubstrings
    //         .add(new MainTextMatchedSubstrings.fromJson(v));
    //   });
    // }
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() => {
        'main_text': this.mainText,
        // 'main_text_matched_substrings':
        //     mainTextMatchedSubstrings.map((v) => v.toJson()).toList(),
        'secondary_text': secondaryText,
      };
}

class Terms {
  int offset;
  String value;

  Terms({
    this.offset,
    this.value,
  });

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() => {
        'offset': offset,
        'value': value,
      };
}
