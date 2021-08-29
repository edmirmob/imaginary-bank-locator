import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';

class ViewMap extends StatefulWidget {
  final List<MapsData> locationData;
  final Function onMapCreated;

  ViewMap(
    this.locationData,
    this.onMapCreated,
  );

  static final LatLng _allLocations =
      LatLng(44.20724262056185, 18.421245142862734);

  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  BitmapDescriptor icon1;
  BitmapDescriptor icon2;
  @override
  void initState() {
    super.initState();
    getIcons();
  }

  getIcons() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/ic_pin_branch.png")
        .then((value) {
      this.icon2 = value;
    });
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/ic_pin_atm.png")
        .then((value) {
      this.icon1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markerList = <Marker>[];

    for (var item in widget.locationData) {
      markerList.add(
        Marker(
            markerId: MarkerId(item.id.toString()),
            position: LatLng(item.lat, item.long),
            infoWindow: InfoWindow(title: item.name, snippet: item.address),
            icon: item.type == "branch" ? icon2 : icon1),
      );
    }
    return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: widget.onMapCreated(),
        initialCameraPosition:
            CameraPosition(target: ViewMap._allLocations, zoom: 9),
        mapType: MapType.normal,
        markers: {
          ...markerList,
        });
  }
}
