import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AppController extends GetxController {
  var currentPosition = const LatLng(34.1981, 72.0452).obs;
  GoogleMapController? mapController;

  var currentMarkerLocation = Rxn<Marker>();

  // Marker? currentMarkerLocation;

  // Get permission from user device
  Future<Position> determinePosition() async {
    if (!await Permission.location.isGranted) {
      PermissionStatus status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
      currentPosition.value = LatLng(position.latitude, position.longitude);
      currentMarkerLocation.value = Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentPosition.value,
        infoWindow: const InfoWindow(title: 'You are here', snippet: 'HI'),
      );
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: currentPosition.value, zoom: 12)),
      );
    } catch (e) {
      print('Error getting current location: $e');
    }
  }
}
