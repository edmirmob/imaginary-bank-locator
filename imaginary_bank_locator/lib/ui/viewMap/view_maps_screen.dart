import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class ViewMapsScreen extends StatefulWidget {
  @override
  _ViewMapsScreenState createState() => _ViewMapsScreenState();
}

class _ViewMapsScreenState extends State<ViewMapsScreen> {
  GoogleMapController _googleMapController;

  List<Marker> markerList = <Marker>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
    markerList = [];
  }

  LatLng curLocation;
  BitmapDescriptor icon1;
  BitmapDescriptor icon2;
  BitmapDescriptor icon3;
  static final LatLng _allLocations =
      LatLng(44.20724262056185, 18.421245142862734);

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
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3.2),
            "assets/images/ic_pin_user.png")
        .then((value) {
      this.icon3 = value;
    });
  }

  LocationData currentLocation;
  var location = new Location();

  myCurrentLocation() async {
    try {
      currentLocation = await location.getLocation();

      curLocation =
          LatLng(currentLocation?.latitude, currentLocation?.longitude);
      markerList.add(Marker(
          markerId: MarkerId('current location'),
          infoWindow: InfoWindow(title: 'Place of user', snippet: 'Location..'),
          position: LatLng(curLocation?.latitude, curLocation?.longitude),
          icon: icon3));
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
    getIcons();

    final mapsProvider = context.read<LocationProvider>();

    return Selector<LocationState, List<MapsData>>(
      selector: (_, listLocation) => listLocation?.locationData,
      builder: (_, list, __) {
        if (mapsProvider.isLocationLoaded()) {
          Future.delayed(Duration(seconds: 0)).then((_) {
            for (var item in list) {
              markerList.add(
                Marker(
                    markerId: MarkerId(item?.id.toString()),
                    position: LatLng(item?.lat, item.long),
                    infoWindow:
                        InfoWindow(title: item?.name, snippet: item?.address),
                    icon: item?.type == "branch" ? icon2 : icon1),
              );
            }
          });
        } else {
          for (var item in list) {
            markerList.add(
              Marker(
                  markerId: MarkerId(item?.id.toString()),
                  position: LatLng(item?.lat, item.long),
                  infoWindow:
                      InfoWindow(title: item?.name, snippet: item?.address),
                  icon: item?.type == "branch" ? icon2 : icon1),
            );
          }
          ;
        }
        return GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              _googleMapController = controller;
            });
          },
          initialCameraPosition: CameraPosition(target: _allLocations, zoom: 9),
          mapType: MapType.normal,
          markers: {
            ...markerList,
          },
        );
      },
    );
  }
}
