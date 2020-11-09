import 'package:GreatePlaces/providers/greate_places.dart';
import 'package:GreatePlaces/screens/add_place.dart';
import 'package:GreatePlaces/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Greate Places"),
          actions: [
            FlatButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AddPlace.routeName),
                child: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatePlaces>(context).feachAndGetData(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<GreatePlaces>(
                  child: Text("No Places added yet!"),
                  builder: (ctx, places, ch) => places.items.length == 0
                      ? ch
                      : ListView.builder(
                          itemCount: places.items.length,
                          itemBuilder: (ct, i) => ListTile(
                            title: Text(places.items[i].title),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(places.items[i].image),
                            ),
                            subtitle: Text(places.items[i].location.adress),
                            onTap: () => Navigator.of(context).pushNamed(
                                PlaceDetaiLsScreen.routeName,
                                arguments: places.items[i].id),
                          ),
                        ),
                ),
        ));
  }
}
