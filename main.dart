import 'package:GreatePlaces/providers/greate_places.dart';
import 'package:GreatePlaces/screens/add_place.dart';
import 'package:GreatePlaces/screens/place_details.dart';
import 'package:GreatePlaces/screens/places_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatePlaces(),
      child: MaterialApp(
        title: 'Greate Places',
        theme:
            ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetaiLsScreen.routeName: (ctx) => PlaceDetaiLsScreen()
        },
      ),
    );
  }
}
