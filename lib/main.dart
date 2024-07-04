import 'package:flutter/material.dart';
import 'package:placesapp/screens/add_place.dart';
import 'package:provider/provider.dart';
import './providers/places.dart';
import './screens/places_list.dart';
import './screens/place_details.dart';

void main() {
  runApp(PlacesApp());
}

class PlacesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = ThemeData();
    appTheme = appTheme.copyWith(
      colorScheme: appTheme.colorScheme.copyWith(
          primary: Color(int.parse('E03C54', radix: 16) + 0xFF000000),
          onPrimary: Color(int.parse('F3F7F3', radix: 16) + 0xFF000000),
          secondary: Color(int.parse('8795A8', radix: 16) + 0xFF000000),
          onSecondary: Color(int.parse('221621', radix: 16) + 0xFF000000),
          background: Color(int.parse('F3F7F3', radix: 16) + 0xFF000000),
          onBackground: Color(int.parse('221621', radix: 16) + 0xFF000000),
          error: Color(int.parse('BC3E52', radix: 16) + 0xFF000000),
          onError: Color(int.parse('F3F7F3', radix: 16) + 0xFF000000),
          surface: Color(int.parse('221621', radix: 16) + 0xFF000000),
          onSurface: Color(int.parse('F3F7F3', radix: 16) + 0xFF000000)),
    );
    return ChangeNotifierProvider<Places>(
      create: (_) {
        return Places();
      },
      child: MaterialApp(
        title: 'pickaPlace',
        theme: appTheme,
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (_) {
            return AddPlace();
          },
          PlaceScreen.routeName: (_) {
            return PlaceScreen();
          }
        },
      ),
    );
  }
}
