
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';

import 'package:imaginary_bank_locator/ui/view_map.dart';
import 'package:provider/provider.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    final internetBookmarksProvider = context.read<MapsProvider>();

    Future.delayed(Duration.zero)
        .then((_) => internetBookmarksProvider.loadLocation());
  }

  List<Marker> customMarkers = [];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraint) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Mobile Assignment'),
            centerTitle: true,
          ),
          body: Selector<LocationState, List<LocationData>>(
            selector: (_, listLocation) => listLocation?.locationData,
            builder: (_, list, __) {
              if (list.length < 0) {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
              return ViewMap(list, () {
                _onMapCreated;
              });
            },
          ),
        );
      },
    );
  }

  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

}
