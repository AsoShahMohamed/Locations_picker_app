import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation placeLocation;
  bool isSelecting;

  MapScreen(
      {this.placeLocation =
          const PlaceLocation(latitude: 37.442, longitude: -122.084),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

  void _getLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('select Location'), actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _selectedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_selectedLocation);
                    },
            )
        ]),
        body: GoogleMap(
          markers: (_selectedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                      markerId: MarkerId('A'),
                      position: _selectedLocation == null
                          ? LatLng(widget.placeLocation.latitude,
                              widget.placeLocation.longitude)
                          : _selectedLocation as LatLng)
                },
          onTap: widget.isSelecting ? _getLocation : null,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.placeLocation.latitude,
                  widget.placeLocation.longitude)),
        ));
  }
}
