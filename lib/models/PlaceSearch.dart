class PlaceSearch {
  final String placeId;
  final String placeName;
  final String placeCountry;
  final String fullDescription;

  PlaceSearch(
      {this.placeId, this.placeName, this.placeCountry, this.fullDescription});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    final terms = json['terms'];

    return PlaceSearch(
        fullDescription: json['description'],
        placeName: terms[0]['value'],
        placeCountry: terms[terms.length - 1]['value'],
        placeId: json['place_id']);
  }
}
