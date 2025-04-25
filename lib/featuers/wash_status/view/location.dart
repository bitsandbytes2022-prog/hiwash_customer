import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationFetcher extends StatefulWidget {
  @override
  _LocationFetcherState createState() => _LocationFetcherState();
}

class _LocationFetcherState extends State<LocationFetcher> {
  String _currentLocation = "Unknown";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = "Location permissions are denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = "Location permissions are permanently denied";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = "Lat: ${position.latitude}, Lon: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: Center(
        child: Text(
          _currentLocation,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
