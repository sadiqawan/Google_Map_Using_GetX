import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app_contoller.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final AppController appController = Get.put(AppController());

  void _onMapCreated(GoogleMapController controller) {
    appController.mapController = controller;
    appController.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Google',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            width: double.infinity,
            child: Obx(() => GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: appController.currentPosition.value,
                    zoom: 10.0,
                  ),
                  markers: appController.currentMarkerLocation.value != null
                      ? {appController.currentMarkerLocation.value!}
                      : {},
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // Implement save location functionality if needed
            },
            child: const Text('Save Your Location'),
          ),
        ],
      ),
    );
  }
}
