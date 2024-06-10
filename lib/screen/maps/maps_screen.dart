import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../dummy_data_maps.dart';
import '../../generated/l10n.dart';
import '../../widget/bottom_sheet.dart';
import '../../widget/button.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late String _darkMapStyle;
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};
  Timer? _locationUpdateTimer;

  void _showBottomSheet(MarkerData data) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Theme.of(context).colorScheme.background,
      isDismissible: true,
      builder: (context) {
        return Container(
          height: (MediaQuery.of(context).size.height) * 0.4,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  elevation: 5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child: ClipOval(
                              child: Image.asset('assets/images/img_profile_user.png', fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(
                            data.name,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Ing. de Software\n#${data.studentCode}'),
                        )
                      ],
                    )
                  )
                ),
                const SizedBox(height: 20),
                Text(
                  "PEN",
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  data.amount.toString(),
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(data.cashType),
                const SizedBox(height: 20),
                BaseElevatedButton(text: S.current.ResponseCashback, onPressed: () {})
                // Agrega más campos aquí si es necesario
              ],
            ),
          ),
        );
      },
    );
  }

  void _addMarkersFromData(List<MarkerData> data) {
    for (var item in data) {
      final marker = Marker(
        markerId: MarkerId(item.studentCode),
        position: item.coordinates,
        onTap: () {
          _showBottomSheet(item);
        },
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

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

  Future<Uint8List> _readImageBytes(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      final Uint8List markerIconBytes =
      await _readImageBytes('assets/images/current_location.png');
      final BitmapDescriptor markerIcon =
      BitmapDescriptor.fromBytes(markerIconBytes);
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.4746,
        );
        _markers.add(
          Marker(
            markerId: MarkerId('current_position'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(title: 'Current Position'),
            icon: markerIcon,
          ),
        );
      });
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition!));
    } catch (e) {
      print('Could not get the location: $e');
    }
  }

  void _startLocationUpdateTimer() {
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getCurrentLocation();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    getCurrentLocation(); // Obtener la ubicación actual al iniciar el widget
    _addMarkersFromData(dummyData);
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  static const CameraPosition _fisiAno = CameraPosition(
    target: LatLng(-12.053315788695889, -77.0855253812269),
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _initialCameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition ?? _fisiAno,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              if (MediaQuery.of(context).platformBrightness ==
                  Brightness.dark) {
                controller.setMapStyle(_darkMapStyle);
              } else {
                controller.setMapStyle(null);
              }
            },
            markers: _markers,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () {
                  showCustomBottomSheet(context);
                },
                child: Icon(Icons.currency_exchange), // Icono del botón
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: Icon(Icons.my_location), // Icono del botón
            ),
          ),
        ],
      ),
    );
  }

  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map/dark_theme_map.json');
  }
}
