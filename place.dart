



import 'dart:io';

import 'package:flutter/cupertino.dart';
class PlaceLocation{
final double longtude;
final double atitude;
final String adress;

PlaceLocation({@required this.atitude,
@required this.adress,
@required this.longtude
});

}
class Place{
final String title;
final String id;
final File  image;
final PlaceLocation location;

Place({@required this.id,
@required this.location,
@required this.image,
@required this.title
}
);

}