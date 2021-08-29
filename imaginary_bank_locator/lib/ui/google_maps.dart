import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class GoogleMaps extends StatefulWidget {
  static const route = '/maps-screen';
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  LatLng curLocation;
  BitmapDescriptor icon1;
  BitmapDescriptor icon2;
  BitmapDescriptor icon3;
  final isActive = BehaviorSubject<int>();
  @override
  void initState() {
    super.initState();

    final internetBookmarksProvider = context.read<MapsProvider>();

    Future.delayed(Duration.zero)
        .then((_) => internetBookmarksProvider.loadLocation());
    getIcons();
    myCurrentLocation();
  }

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

  List<Marker> markerList = <Marker>[];
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
    return LayoutBuilder(
      builder: (context, boxConstraint) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(4, 160, 160, 1),
            title: Text('Mobile Assignment'),
            centerTitle: true,
          ),
          body: Selector<LocationState, List<MapsData>>(
            selector: (_, listLocation) => listLocation?.locationData,
            builder: (_, list, __) {
              for (var item in list) {
                markerList.add(
                  Marker(
                      markerId: MarkerId(item.id.toString()),
                      position: LatLng(item.lat, item.long),
                      infoWindow:
                          InfoWindow(title: item.name, snippet: item.address),
                      icon: item.type == "branch" ? icon2 : icon1),
                );
              }

              return GoogleMap(
                onMapCreated: (controller) => _googleMapController = controller,
                initialCameraPosition:
                    CameraPosition(target: _allLocations, zoom: 9),
                mapType: MapType.normal,
                markers: {
                  ...markerList,
                },
              );
            },
          ),
          bottomNavigationBar: StreamBuilder<int>(
              stream: isActive.stream,
              builder: (context, activeTab) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                activeTab.data == 0
                                    ? Color.fromRGBO(4, 160, 160, 1)
                                    : Color.fromRGBO(164, 207, 87, 1))),
                        onPressed: () {
                          isActive.add(0);
                          _googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: curLocation, zoom: 9)));
                          ;
                        },
                        child: Text('My location'),
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                activeTab.data == 1
                                    ? Color.fromRGBO(4, 160, 160, 1)
                                    : Color.fromRGBO(164, 207, 87, 1))),
                        onPressed: () {
                          isActive.add(1);
                        },
                        child: Text('Location'),
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                activeTab.data == 2
                                    ? Color.fromRGBO(4, 160, 160, 1)
                                    : Color.fromRGBO(164, 207, 87, 1))),
                        onPressed: () {
                          isActive.add(2);
                        },
                        child: Text('List'),
                      ),
                    ),
                  ],
                );
              }),
        );
      },
    );
  }
}
