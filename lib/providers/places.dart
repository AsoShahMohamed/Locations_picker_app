import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../helpers/sql_functions.dart';
import '../helpers/maps_helper.dart';

class Places with ChangeNotifier {
  List<Place> _locations = [];

  List<Place> get getLocations {
    return [..._locations];
  }

  Future<void> addPlace(
      Map<String, Object> data, PlaceLocation location) async {
    String placeAddress = await GoogleLocationHelper.getLocationAdresss(
        location.latitude, location.longitude);

    final placeItem = Place(
        id: DateTime.now().toString(),
        title: data['title'] as String,
        Image: data['image'] as File,
        location: PlaceLocation(
            latitude: location.latitude,
            longitude: location.longitude,
            address: placeAddress));

    _locations.add(placeItem);

    notifyListeners();

    SqlLite.insert('places', {
      'id': placeItem.id,
      'title': placeItem.title,
      'image': placeItem.Image.path,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'address': placeAddress
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final records = await SqlLite.fetchRecords('places');

    print(records[0]);
    _locations = records
        .map((e) => Place(
            Image: File(e['image']),
            id: e['id'],
            title: e['title'],
            location: PlaceLocation(
                latitude: e['latitude'],
                longitude: e['longitude'],
                address: e['address'])))
        .toList();

    notifyListeners();
  }

  Place findById(String key) {
    return _locations.firstWhere((element) => element.id == key);
  }
}
