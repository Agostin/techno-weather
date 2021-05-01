import 'package:flutter/material.dart';
import 'package:techno_weather/models/PlaceSearch.dart';
import 'package:techno_weather/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final placesService = PlacesService();

  List<PlaceSearch> searchResult;

  searchPlaces(String searchTerm) async {
    searchResult = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
