import 'package:flutter/foundation.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_filter.dart';


class LocationState {
  final List<MapsData> locationData;
  final bool loading;
   final LocationFilter filter;

  LocationState({
    @required this.locationData,
    @required this.loading,
    @required this.filter
  });

  LocationState copyWith({
    List<MapsData> locationData,
    bool loading,
    LocationFilter filter,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      loading: loading ?? this.loading,
      filter:  filter ?? this.filter
    );
  }
}

class LocationInitialState extends LocationState {
  LocationInitialState()
      : super(
          locationData: [],
          loading: false,
          filter: LocationInitialFilter()
        );
}