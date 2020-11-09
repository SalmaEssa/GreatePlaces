import 'dart:io';

import 'package:GreatePlaces/helpers/location_helper.dart';
import 'package:GreatePlaces/models/place.dart';
import 'package:GreatePlaces/providers/greate_places.dart';
import 'package:GreatePlaces/widgets/image_input.dart';
import 'package:GreatePlaces/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = "/add-place";

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final titleController = TextEditingController();
  File _savedImg;
  PlaceLocation _selectedPlace;
  void _submitForm() {
    //  print("krkrkkrkrkrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    if (titleController.text.isEmpty ||
        _savedImg == null ||
        _selectedPlace == null) {
      // print("hhhhhhhhhhhhhhhh");
      return;
    }
    Provider.of<GreatePlaces>(context, listen: false)
        .addPlace(titleController.text, _savedImg, _selectedPlace);
  }

  void _saveImg(File pickedImg) {
    _savedImg = pickedImg;
  }

  Future<void> _savePlace(PlaceLocation pl) async {
    var adress = await LocationHelper.tCity(pl.atitude, pl.longtude);

    var lo = await LocationHelper.tCity(pl.atitude, pl.longtude);

    _selectedPlace =
        PlaceLocation(atitude: pl.atitude, adress: lo, longtude: pl.longtude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_saveImg),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_savePlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: () {
              _submitForm();
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.add),
            label: Text("Add Place"),
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
          ),
        ],
      ),
    );
  }
}
