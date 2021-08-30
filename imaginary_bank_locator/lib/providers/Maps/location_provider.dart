import 'dart:async';

import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/core/repositories/maps_respitory.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_filter.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:state_notifier/state_notifier.dart';


class LocationProvider extends StateNotifier<LocationState>
    with LocatorMixin {
  LocationProvider() : super(LocationInitialState());
StreamSubscription _filterSubscription;
  bool isLocationLoaded() {
    return state.locationData.length > 0;
  }

  Future<void> loadLocation() async {
    try {
      state = state.copyWith(
        loading: true,
      );
      final result = await get_location(state?.filter);
      state = state.copyWith(
        locationData: [...result],
        loading: false,
      );
    } catch (_) {
      _onLocationLoadingError();
    }
  }
  Future<void> filterLocation(LocationFilter filter) async {
    state = state.copyWith(
   
      loading: true,
      filter: filter,
    );


    _filterSubscription?.cancel();
    _filterSubscription = Stream.fromFuture(
      get_location( state.filter),
    ).listen(
      (result) {
        state = state.copyWith(
          
          loading: false,
          locationData: [...result],
        
        
        );
      },
    );
  }

  

  Future<List<MapsData>> get_location(LocationFilter filter) {
    return read<MapsRepository>().getLocationData(filter.text, );
  }

  void _onLocationLoadingError() {
    // showAlertDialog(
    //     translate('Can\'t load announcements'),
    //     translate(
    //         'There was an error while loading announcements. Please try again later.'));
  }
}