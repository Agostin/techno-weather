import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:techno_weather/models/PlaceSearch.dart';
import 'package:techno_weather/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  // final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  Position currentPosition;
  List<PlaceSearch> searchResult;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    // currentLocation = await geolocatorService.getCurrentLocation();
    // notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResult = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
