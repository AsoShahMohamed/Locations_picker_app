import 'package:flutter/material.dart';
import './add_place.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../widgets/List_item.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('choose a place!'), actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlace.routeName);
            },
          )
        ]),
        body: FutureBuilder(
          future:
              Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
          builder: (_, SnapShotState) {
            return SnapShotState.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<Places>(
                    child: const Center(
                        child: Text('There are no Places to show..')),
                    builder: (_, list, ch) {
                      final items = list.getLocations;
                      return items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemBuilder: (_, counter) {
                                return PlaceItem(items[counter]);
                              },
                              itemCount: items.length,
                              padding: EdgeInsets.all(10),
                            );
                    });
          },
        ));
  }
}
