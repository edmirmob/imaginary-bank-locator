import 'package:imaginary_bank_locator/core/models/maps.dart';
import 'package:imaginary_bank_locator/core/repositories/maps_respitory.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:state_notifier/state_notifier.dart';


class MapsProvider extends StateNotifier<LocationState>
    with LocatorMixin {
  MapsProvider() : super(LocationInitialState());

  bool inLocationLoaded() {
    return state.locationData.length > 0;
  }

  Future<void> loadLocation() async {
    try {
      state = state.copyWith(
        loading: true,
      );
      final result = await get_location();
      state = state.copyWith(
        locationData: [...result],
        loading: false,
      );
    } catch (_) {
      _onLocationLoadingError();
    }
  }

  

  Future<List<MapsData>> get_location() {
    return read<MapsRepository>().getLocationData();
  }

  void _onLocationLoadingError() {
    // showAlertDialog(
    //     translate('Can\'t load announcements'),
    //     translate(
    //         'There was an error while loading announcements. Please try again later.'));
  }
}