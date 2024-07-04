
import 'dart:io';
class Place {
 final String id;

 final File Image;

final PlaceLocation?  location;

final String title;

Place({required this.id, required this.title, required this.Image,  this.location});

}


class PlaceLocation{

  final double longitude;
  final double latitude;

  final String? address;

  const PlaceLocation({required this.longitude, required this.latitude, this.address});
}
