import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/maps_helper.dart';
import '../screens/googlemap_screen.dart';

class MapPreview extends StatefulWidget {
  final Function setLocationCoord;
  const MapPreview(this.setLocationCoord);

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  String? _mapLink;

  void _renderImage(double lat, double long) {
    final String staticMapUrl =
        GoogleLocationHelper.getStaticImage(longitude: lat, latitude: long);

    setState(() {
      _mapLink = staticMapUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final loc = await Location.instance.getLocation();
      _renderImage(loc.latitude as double, loc.longitude as double);
      widget.setLocationCoord(loc.latitude, loc.longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _openMapScreen() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) {
              return MapScreen(
                isSelecting: true,
              );
            }));

    if (selectedLocation == null) {
      return;
    }
    _renderImage(selectedLocation.latitude, selectedLocation.longitude);
    widget.setLocationCoord(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 200,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: _mapLink == null
                ? Text(
                    'current location',
                    style: TextStyle(fontSize: 20),
                  )
                : Image.network(
                    _mapLink!,
                    fit: BoxFit.cover,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0),
                  shadowColor: Colors.white.withOpacity(0),
                  foregroundColor: Theme.of(context).colorScheme.primary),
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('current'),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0),
                    shadowColor: Colors.white.withOpacity(0),
                    foregroundColor: Theme.of(context).colorScheme.primary),
                onPressed: _openMapScreen,
                icon: Icon(Icons.map),
                label: Text('pick your location')),
          ],
        )
      ],
    );
  }
}
