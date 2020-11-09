import 'dart:io';

import 'package:GreatePlaces/helpers/db_helper.dart';
import 'package:GreatePlaces/models/place.dart';
import 'package:flutter/material.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image, PlaceLocation location) {
    final date = DateTime.now().toString();
    _items.add(Place(id: date, title: title, image: image, location: location));
    notifyListeners();
    //print("addeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed");
    //print(location.adress);
    DbHelper.insert("Greateplaces", {
      "id": date,
      "title": title,
      "image": image.path,
      "lat": location.atitude,
      "long": location.longtude,
      "adress": location.adress
    });
  }

  Future<void> feachAndGetData() async {
    final data = await DbHelper.getData("Greateplaces");
    _items = data
        .map((e) => Place(
            id: e["id"],
            location: PlaceLocation(
                atitude: e["lat"], adress: e["adress"], longtude: e["long"]),
            image: File(e["image"]),
            title: e["title"]))
        .toList();
  }

  Place getPlaceById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
