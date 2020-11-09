import 'package:GreatePlaces/helpers/location_helper.dart';
import 'package:GreatePlaces/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:simple_location_picker/utils/slp_constants.dart';

class LocationInput extends StatefulWidget {
  Function onpressedPlace;
  LocationInput(this.onpressedPlace);
  @override
  _State createState() => _State();
}

class _State extends State<LocationInput> {
  String _mapView;

  Future<void> _currentLocation() async {
    final location = await Location().getLocation();

    setState(() {
      _mapView = LocationHelper.getStaticImageWithMarker(
          location.altitude, location.longitude);
      PlaceLocation newPlace = PlaceLocation(
          atitude: location.altitude,
          adress: null,
          longtude: location.longitude);
      widget.onpressedPlace(newPlace);
      //LocationHelper.tCity(location.altitude, location.longitude);
    });
  }

  void dynamicLocation(double latitude, double longitude) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SimpleLocationPicker(
                  zoomLevel: 10,
                  initialLatitude: latitude,
                  initialLongitude: longitude,
                ))).then((value) {
      if (value != null) {
        setState(() {
          _mapView = LocationHelper.getStaticImageWithMarker(
              value.latitude, value.longitude);
          PlaceLocation newPlace = PlaceLocation(
              atitude: value.latitude, adress: null, longtude: value.longitude);
          widget.onpressedPlace(newPlace);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 250,
          width: double.infinity,
          child: _mapView == null
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _mapView,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _currentLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: () => dynamicLocation(30, 30),
              icon: Icon(Icons.map),
              label: Text("Select on map"),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
