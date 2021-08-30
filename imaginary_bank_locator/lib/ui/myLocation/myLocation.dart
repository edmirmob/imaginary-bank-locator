import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  GoogleMapController _googleMapController;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markerList1 = <Marker>[];

  @override
  void initState() {
    super.initState();
    myCurrentLocation();
    final mapsProvider = context.read<LocationProvider>();

    Future.delayed(Duration.zero).then((_) => mapsProvider.loadLocation());
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  BitmapDescriptor icon3;

  getIcons() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/ic_pin_user.png")
        .then((value) {
      this.icon3 = value;
    });
  }

  static final LatLng _allLocations =
      LatLng(44.20724262056185, 18.421245142862734);
  LocationData currentLocation;
  var location = new Location();
  LatLng curLocation;
  myCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();

      curLocation =
          LatLng(currentLocation?.latitude, currentLocation?.longitude);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        String error = 'Permission denied';
        print(error);
      }
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0)).then((value) {
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _allLocations, zoom: 9)));
    });

    markerList1.add(Marker(
      markerId: MarkerId('current location'),
      infoWindow: InfoWindow(title: 'Place of user', snippet: 'Location..'),
      position: LatLng(_allLocations?.latitude, _allLocations?.longitude),
      icon: BitmapDescriptor.defaultMarker,
    ));

    return GoogleMap(
      myLocationEnabled: true,
      onMapCreated: (controller) => _controller.complete(controller),
      initialCameraPosition: CameraPosition(target: _allLocations, zoom: 9),
      mapType: MapType.normal,
      markers: {
        ...markerList1,
      },
    );
  }
}
