class PlaceSearch {
  final String placeId;
  final String placeName;
  final String fullDescription;

  PlaceSearch({this.placeId, this.placeName, this.fullDescription});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) => new PlaceSearch(
      fullDescription: json['description'],
      placeName: json['structured_formatting']['main_text'],
      placeId: json['place_id']);
}
