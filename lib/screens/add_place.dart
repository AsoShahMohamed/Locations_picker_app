import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/image_preview.dart';
import '../providers/places.dart';
import '../widgets/map_preview.dart';
import '../models/place.dart';

class AddPlace extends StatelessWidget {
  static const routeName = '/add-place';

  File? imageFile;
  void setImage(File image) {
    imageFile = image;
  }

  final titleController = TextEditingController();

  PlaceLocation? location;

  void _setLocationCoordinate(double lat, double long) {
    location = PlaceLocation(latitude: lat, longitude: long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a Place!')),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'enter a title',
                      // constraints: BoxConstraints(minWidth: double.infinity)
                      labelText: 'Title'),
                ),
                SizedBox(
                  height: 10,
                ),
                ImagePreview(setImage),
                SizedBox(
                  height: 5,
                ),
                MapPreview(_setLocationCoordinate)
              ]),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
            child: Text('press to Add'),
            onPressed:  () async {
              if (imageFile == null || titleController.text.isEmpty || location == null) {
                return;
              }
             await  Provider.of<Places>(context, listen: false).addPlace(
                  {'title': titleController.text, 'image': imageFile as Object},
                  location as PlaceLocation);
              Navigator.of(context).pop();
            })
      ]),
    );
  }
}
