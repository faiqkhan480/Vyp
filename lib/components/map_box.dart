import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vyv/controllers/home_controller.dart';

class MapBox extends StatefulWidget {
  const MapBox({Key? key}) : super(key: key);

  @override
  _MapBoxState createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  HomeController get homeController => Get.find<HomeController>();
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  List<Marker> listMarkers = [];

  CameraPosition _kGooglePlex = CameraPosition(
      // bearing: 192.8334901395799,
      target: LatLng(0.0, 0.0),
      zoom: 19.151926040649414);

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(homeController.spots.first.latitude!.replaceAll(",", ".")), double.parse(homeController.spots.first.longitude!.replaceAll(",", "."))),
      zoom: 15,
      // bearing: 25,
      // tilt: 75,
    );

    homeController.spots.forEach((s) {
      double _lat = double.parse(s.latitude!.replaceAll(",", "."));
      double _long = double.parse(s.longitude!.replaceAll(",", "."));
      _addMarker(
        LatLng(_lat, _long),
        s.spotName!,
        BitmapDescriptor.defaultMarker,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(markers.values),
          onMapCreated: (GoogleMapController controller) {
            if(listMarkers.isNotEmpty)
              controller.moveCamera(CameraUpdate.newLatLng(listMarkers[listMarkers.length ~/ 2].position));
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId =  MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
    listMarkers.add(marker);
  }
}
