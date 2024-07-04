import 'package:flutter/material.dart';
import 'package:placesapp/screens/googlemap_screen.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../models/place.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/place-details';

  @override
  Widget build(BuildContext context) {
    final key = ModalRoute.of(context)?.settings.arguments as String;
    final place = Provider.of<Places>(context, listen: false).findById(key);

    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              child: Image.file(
                place.Image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              place.location?.address as String,
              style: TextStyle(color: Colors.grey, fontSize: 24),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(fullscreenDialog: true,builder: (_) {
                    return MapScreen(
                      placeLocation: place.location as PlaceLocation,
                      isSelecting: false,
                    );
                  }));
                },
                child: Text('look on map'))
          ],
        ));
  }
}
