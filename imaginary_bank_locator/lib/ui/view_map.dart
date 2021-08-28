import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';

class ViewMap extends StatelessWidget {
  final List<LocationData> locationData;
  final Function onMapCreated;

  ViewMap(
    this.locationData,
    this.onMapCreated,
  );

  static final LatLng _allLocations =
      LatLng(44.20724262056185, 18.421245142862734);

  @override
  Widget build(BuildContext context) {
    List<Marker> markerList = <Marker>[];

    for (var item in locationData) {
      markerList.add(
        Marker(
          markerId: MarkerId(item.id.toString()),
          position: LatLng(item.lat, item.long),
          infoWindow: InfoWindow(title: item.name, snippet: item.address),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueMagenta),
        ),
      );
    }
    return GoogleMap(
        onMapCreated: onMapCreated(),
        initialCameraPosition: CameraPosition(target: _allLocations, zoom: 9),
        mapType: MapType.normal,
        markers: {
          ...markerList,
        });
  }
}
