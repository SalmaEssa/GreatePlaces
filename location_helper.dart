import 'dart:convert';
import 'package:mapbox_geocoding/mapbox_geocoding.dart';

import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  String apiKey =
      'pk.eyJ1Ijoic2FsbWFlc3NhIiwiYSI6ImNraDV3ZDIydzA0eWIycG81Mmo4ejY0M2MifQ.9zwgINHI3S03yF5E9CwLvA';
  static String generateLocation(double longitude, double latitude) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=pk.eyJ1Ijoic2FsbWFlc3NhIiwiYSI6ImNraDV3ZDIydzA0eWIycG81Mmo4ejY0M2MifQ.9zwgINHI3S03yF5E9CwLvA';
  }

  static StaticImage staticImage = StaticImage(
      apiKey:
          "pk.eyJ1Ijoic2FsbWFlc3NhIiwiYSI6ImNraDV3ZDIydzA0eWIycG81Mmo4ejY0M2MifQ.9zwgINHI3S03yF5E9CwLvA");

  /* static Future<String> getAdressReadAble(double lati, double longit) async {
    final url =
        "http://api.tiles.mapbox.com/v4/geocode/{index}/$longit,$lati.json?access_token=pk.eyJ1Ijoic2FsbWFlc3NhIiwiYSI6ImNraDV3ZDIydzA0eWIycG81Mmo4ejY0M2MifQ.9zwgINHI3S03yF5E9CwLvA";
    final response = await http.get(url);
    print("kkkkkkkkkkkkkkkkk");
    print(json.decode(response.body));
    return "hhhh";
  }
 */
  static String getStaticImageWithMarker(double latitu, double langit) =>
      staticImage.getStaticUrlWithMarker(
        center: Location(lat: latitu, lng: langit),
        marker: MapBoxMarker(
            markerColor: Color.rgb(1, 0, 0),
            markerLetter: 'p',
            markerSize: MarkerSize.LARGE),
        height: 400,
        width: 600,
        zoomLevel: 5,
        style: MapBoxStyle.Streets,
        render2x: true,
      );
  ////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  static MapboxGeocoding geocoding = MapboxGeocoding(
      'pk.eyJ1Ijoic2FsbWFlc3NhIiwiYSI6ImNraDV3ZDIydzA0eWIycG81Mmo4ejY0M2MifQ.9zwgINHI3S03yF5E9CwLvA');

  ///Reverse geocoding. Get place name from latitude and longitude.
  static Future<String> tCity(double lat, double lng) async {
    try {
      var reverseModel = await LocationHelper.geocoding.reverseModel(lat, lng);
      print(reverseModel.features[0].placeName);
      return reverseModel.features[0].placeName;
    } catch (Excepetion) {
      return 'Reverse Geocoding Error';
    }
  }
}
