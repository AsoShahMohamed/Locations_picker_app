import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleLocationHelper {
  static String staticMapApiKey = '';
  static String getStaticImage(
      {required double longitude, required double latitude}) {
    final stringUrl = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: '/maps/api/staticmap',
        queryParameters: {
          'center': '$latitude,$longitude',
          'zoom': '13',
          'size': '600x300',
          'maptype': 'roadmap',
          'markers': 'color:blue|label:P|$latitude,$longitude',
          'key': staticMapApiKey
        }).toString();

    return stringUrl;
  }

  static Future<String> getLocationAdresss(double lat, double long) async {
    final uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json',
        {'latlng': '$lat,$long', 'key': ''});

final uri2= Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=''');
    try {
      final response = await http.get(uri2);
//problem with the request otherwise it would return an empty list which would resolve to an empty string..
      return json.decode(response.body)['results'][0]['formatted_address'];
    } catch (e) {
      return 'failedhttprequestforAddress';
    }
  }
}
