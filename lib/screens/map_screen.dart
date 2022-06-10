import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/spot_model.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/text_component.dart';

class MapScreen extends StatefulWidget {
  final Spot? spot;
  const MapScreen({Key? key, this.spot}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Google Maps controller
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  List<Marker> listMarkers = [];
  Spot? get _spot => widget.spot;
  double _lat = 0.0;
  double _long = 0.0;

  CameraPosition _kGooglePlex = CameraPosition(
    // bearing: 192.8334901395799,
      target: LatLng(0.0, 0.0),
      zoom: 19.151926040649414);

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    setState(() {
      markers[markerId] = marker;
      listMarkers.add(marker);
    });
  }

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(double.parse(_spot!.latitude!.replaceAll(",", ".")), double.parse(_spot!.longitude!.replaceAll(",", "."))),
      zoom: 15,
      // bearing: 25,
      // tilt: 75,
    );
    _lat = double.parse(_spot!.latitude!.replaceAll(",", "."));
    _long = double.parse(_spot!.longitude!.replaceAll(",", "."));
    _addMarker(
      LatLng(_lat, _long),
      _spot!.id!.toString(),
      BitmapDescriptor.defaultMarker,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: TextWidget(
          text: Constants.appName,
          color: AppColors.primaryColor,
          size: 5,
          align: TextAlign.center,
          family: 'GemunuLibre',
        ),
        leading: IconButton(onPressed: () => Get.back(canPop: true, id: 1), icon: SvgPicture.asset("assets/images/svgs/arrow_backward.svg")),
        actions: [],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),

      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          // if(listMarkers.isNotEmpty)
          //   controller.moveCamera(CameraUpdate.newLatLng(listMarkers[listMarkers.length ~/ 2].position));
          _controller.complete(controller);
        },
      ),

    );
  }
}
