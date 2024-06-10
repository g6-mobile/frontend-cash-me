import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData {
  final String name;
  final String studentCode;
  final LatLng coordinates;
  final double amount;
  final String cashType;

  MarkerData({
    required this.name,
    required this.studentCode,
    required this.coordinates,
    required this.amount,
    required this.cashType,
  });
}

List<MarkerData> dummyData = [
  MarkerData(
    name: 'John Doe',
    studentCode: '123456',
    coordinates: LatLng(-12.055887470998593, -77.08398420218869),
    amount: 100.0,
    cashType: 'Digital a efectivo',
  ),
  MarkerData(
    name: 'Jane Smith',
    studentCode: '789012',
    coordinates: LatLng(-12.05341054019216, -77.08581390890141),
    amount: 200.0,
    cashType: 'Efectivo a digital',
  ),
  MarkerData(
    name: 'Bob Johnson',
    studentCode: '345678',
    coordinates: LatLng(-12.054195184899012, -77.08548642336714),
    amount: 150.0,
    cashType: 'Digital a efectivo',
  ),
  MarkerData(
    name: 'Alice Williams',
    studentCode: '901234',
    coordinates: LatLng(-12.054380663723906, -77.08498571886193),
    amount: 250.0,
    cashType: 'Digital a efectivo',
  ),
  // Agrega más datos aquí
];