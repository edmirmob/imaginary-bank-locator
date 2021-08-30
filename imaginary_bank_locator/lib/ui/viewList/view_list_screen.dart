import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:imaginary_bank_locator/shared/search_field.dart';
import 'package:imaginary_bank_locator/ui/viewDetails/view_details_screen.dart';
import 'package:provider/provider.dart';

class ViewListScreen extends StatefulWidget {
  const ViewListScreen({Key key}) : super(key: key);
  static const route = '/view-list-screen';
  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  LatLng curLocation;
  @override
  void initState() {
    super.initState();

    final mapsProvider = context.read<LocationProvider>();

    Future.delayed(Duration.zero).then((_) => mapsProvider.loadLocation());
  }

  @override
  Widget build(BuildContext context) {
    final locationState = context.read<LocationState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SearchField(
          initialValue: locationState.filter.text,
          onChanged: (String value) {
            context.read<LocationProvider>().filterLocation(
                  locationState.filter.copyWith(
                    text: value.toUpperCase(),
                  ),
                );
          },
          hint: ('Search'),
        ),
        Expanded(
          child: Selector<LocationState, List<MapsData>>(
              selector: (_, listLocation) => listLocation?.locationData,
              builder: (_, list, __) {
                return listData(list, context);
              }),
        ),
      ],
    );
  }

  Widget listData(List<MapsData> data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: data != null ? data.length : 0,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: Column(
                  children: [
                    Container(
                      color: Color.fromRGBO(122, 204, 204, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewDetailsScreen(),
                                    settings: RouteSettings(
                                      arguments: data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Text(data[index]?.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image.asset(data[index].type == 'atm'
                                  ? 'assets/images/ic_atm.png'
                                  : 'assets/images/ic_branch.png')),
                        ],
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(99, 192, 192, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(data[index]?.address,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
