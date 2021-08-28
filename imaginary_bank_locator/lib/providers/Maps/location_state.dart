import 'package:flutter/foundation.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';


class LocationState {
  final List<LocationData> locationData;
  final bool loading;

  LocationState({
    @required this.locationData,
    @required this.loading,
  });

  LocationState copyWith({
    List<LocationData> locationData,
    bool loading,
  }) {
    return LocationState(
      locationData: locationData ?? this.locationData,
      loading: loading ?? this.loading,
    );
  }
}

class LocationInitialState extends LocationState {
  LocationInitialState()
      : super(
          locationData: [],
          loading: false,
        );
}