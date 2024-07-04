import 'package:flutter/material.dart';
import 'package:placesapp/screens/place_details.dart';
import '../models/place.dart';

class PlaceItem extends StatelessWidget {
  final Place place;

  PlaceItem(this.place);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.surface,
        leading: CircleAvatar(
          backgroundImage: FileImage(place.Image),
        ),
        title: Text(
          place.title as String,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(place.location?.address as String),
        onTap: () {
          Navigator.of(context)
              .pushNamed(PlaceScreen.routeName, arguments: place.id);
        },
      ),
    );
  }
}
