import 'dart:async';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_geocoding/google_geocoding.dart' as geo;
import 'package:location/location.dart';

class LocationService with ChangeNotifier {
  Location? location;

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  String? _currentLocation;

  String? get currentLocation => _currentLocation;

  Future<LocationData> _getLocation() async {
    location = new Location();
    _serviceEnabled = await location!.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location!.requestService();
      if (!_serviceEnabled!) {
        return Future.error("Permission Denied");
      }
    }

    _permissionGranted = await location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error("Permission Denied");
      }
    }
    return await location!.getLocation();
  }

  Future getCurrentLocation() async {
    try {
      geo.LatLon coordinates = await _getLocation().then((value) => geo.LatLon(value.latitude!, value.longitude!));

      var googleGeocoding = geo.GoogleGeocoding(Constants.googleApi);
      var result = await googleGeocoding.geocoding.getReverse(coordinates);
      print(result!.results);
      print(coordinates);
      notifyListeners();
    } catch (e) {}
  }
}
