import 'package:GreatePlaces/providers/greate_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';

class PlaceDetaiLsScreen extends StatelessWidget {
  static const routeName = "/PlaceDetails";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatePlaces>(context, listen: false).getPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.adress,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SimpleLocationPicker(
                              displayOnly: true,
                              zoomLevel: 10,
                              initialLatitude: selectedPlace.location.atitude,
                              initialLongitude: selectedPlace.location.longtude,
                            )));
              },
              child: Text(
                "Show On Map",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }
}
