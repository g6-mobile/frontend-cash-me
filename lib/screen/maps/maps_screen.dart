import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late String _darkMapStyle;
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        );
        _markers.add(
          Marker(
            markerId: MarkerId('current_position'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(title: 'Current Position'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    } catch (e) {
      print('Could not get the location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    getCurrentLocation();  // Obtener la ubicación actual al iniciar el widget
  }

  static const CameraPosition _fisiAno = CameraPosition(
    target: LatLng(-12.053315788695889, -77.0855253812269),
    zoom: 19.151926040649414,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(-12.059630621905079, -77.07792673597197),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: _initialCameraPosition == null
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _initialCameraPosition ?? _fisiAno,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            controller.setMapStyle(_darkMapStyle);
          },
          markers: _markers,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map/dark_theme_map.json');
  }
}
