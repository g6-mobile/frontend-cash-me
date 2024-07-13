import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pocket_swap_fisi/domain/entities/chat/create_room.dart';
import 'package:pocket_swap_fisi/domain/entities/transaction_pending_by_student_code.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:pocket_swap_fisi/providers/transaction_provider.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/studentByCode.dart';
import '../../dummy_data_maps.dart';
import '../../generated/l10n.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../routes/app_router.gr.dart';
import '../../widget/bottom_sheet.dart';
import '../../widget/button.dart';

@RoutePage()
class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  late String _darkMapStyle;
  CameraPosition? _initialCameraPosition;
  Set<Marker> _markers = {};
  late Position position;
  late AuthProvider authProvider =
  Provider.of<AuthProvider>(context, listen: false);
  late TransactionProvider transactionProvider =
  Provider.of<TransactionProvider>(context, listen: false);
  late UserProvider userProvider =
  Provider.of<UserProvider>(context, listen: false);
  late RoomProvider roomProvider =
  Provider.of<RoomProvider>(context, listen: false);
  Timer? _locationUpdateTimer;
  ValueNotifier<Brightness> brightnessNotifier =
  ValueNotifier(WidgetsBinding.instance!.window.platformBrightness);
  Timer? _updateTimer;
  late Future<StudentByCode> _studentFuture;

  void _showBottomSheet(TransactionPendingByStudentCode transaction) {
    _studentFuture =
        authProvider.studentByCode(transaction.initiatorCode.toString());
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      isDismissible: true,
      builder: (context) {
        return FutureBuilder<StudentByCode>(
          future: _studentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              StudentByCode student = snapshot.data!;
              return Container(
                height: (MediaQuery
                    .of(context)
                    .size
                    .height) * 0.4,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 35, vertical: 5),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Card(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondaryContainer,
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
                                        child: Image.network(
                                            student.userPhoto,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    title: Text(
                                      student.name,
                                      style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                    Text('${student.major}\n#${transaction
                                        .initiatorCode}'),
                                  )
                                ],
                              ))),
                      const SizedBox(height: 20),
                      const Text(
                        "PEN",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        transaction.amount.toString(),
                        style: const TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        transaction.operationType == 1
                            ? S.current.DigitalToCash
                            : S.current.CashToDigital,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BaseElevatedButton(
                          text: S.current.ResponseCashback,
                          onPressed: () async {
                            final user2 = await userProvider.getUserByStudentCode(
                                transaction.initiatorCode.toString());


                              final createRoom = CreateRoom(
                                  name: "${authProvider.user?.firstName} 1",
                                  members: [
                                    authProvider.user!.id,
                                    user2!.id
                                  ]);
                              roomProvider.addRoom(createRoom);
                              AutoRouter.of(context).push(const ChatListRoute());


                          })
                      // Agrega más campos aquí si es necesario
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _addMarkersFromData() {
    // Accede a los datos de las transacciones a través del TransactionProvider
    print('Adding markers from data');
    final transactions = transactionProvider.transactionsForMap?.data
        .transactions ?? [];
    for (var transaction in transactions) {
      print('Transaction: ${transaction.id}');
      print('Transaction: ${transaction.location.coordinates[0]}');
      final marker = Marker(
        markerId: MarkerId(transaction.id),
        position: LatLng(transaction.location.coordinates[1],
            transaction.location.coordinates[0]),
        onTap: () {
          _showBottomSheet(transaction);
        },
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

  Future<void> updateTransactionsAndMarkers() async {
    // Obtén las nuevas transacciones del servidor
    await transactionProvider.getTransactionsForMapProvider(
        authProvider.user!.studentCode ?? '');

    // Filtra los marcadores para mantener solo el marcador 'current_position'
    Set<Marker> newMarkers = {};
    for (var marker in _markers) {
      if (marker.markerId.value == 'current_position') {
        newMarkers.add(marker);
      }
    }

    // Asigna el nuevo conjunto de marcadores
    setState(() {
      _markers = newMarkers;
    });

    // Agrega nuevos marcadores para cada transacción en la lista actualizada de transacciones
    _addMarkersFromData();
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
      position = await determinePosition();
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.4746,
        );
        updateMakerPosition();
      });
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition!));
    } catch (e) {
      print('Could not get the location: $e');
    }
  }

  Future<void> updateMakerPosition() async {
    print("Updating marker position");
    final Uint8List markerIconBytes =
    await _readImageBytes('assets/images/current_location.png');
    final BitmapDescriptor markerIcon =
    BitmapDescriptor.fromBytes(markerIconBytes);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('current_position'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: 'Current Position'),
          icon: markerIcon,
        ),
      );
    });
  }

  void _startLocationUpdateTimer() {
    _locationUpdateTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
          updateMakerPosition();
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _loadMapStyles();
    getCurrentLocation();
    _startLocationUpdateTimer();
    _startUpdateTimer();
    _loadUserAndTransactions();
  }

  Future<void> _loadUserAndTransactions() async {
    await authProvider.loadUser();
    if (authProvider.user != null) {
      await transactionProvider.getTransactionsForMapProvider(
          authProvider.user!.studentCode ?? '');
      _addMarkersFromData();
    }
  }

  void _startUpdateTimer() {
    _updateTimer = Timer.periodic(
      const Duration(seconds: 10),
      // Cambia esto al intervalo de tiempo que prefieras
          (timer) => updateTransactionsAndMarkers(),
    );
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    _updateTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      brightnessNotifier.value =
          WidgetsBinding.instance!.window.platformBrightness;
    }
    super.didChangeAppLifecycleState(state);
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
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCameraPosition ?? _fisiAno,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  if (themeProvider.themeMode == ThemeMode.dark) {
                    controller.setMapStyle(_darkMapStyle);
                  } else {
                    controller.setMapStyle(null);
                  }
                },
                markers: _markers,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () async {
                  await authProvider.loadUser();
                  if (authProvider.user != null) {
                    await transactionProvider
                        .getTransactionPendingProvider(
                        authProvider.user!.studentCode ?? '');
                    showCustomBottomSheet(
                        context,
                        position,
                        authProvider.user!,
                        transactionProvider.transactionPending!);
                  }
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
