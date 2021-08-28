import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:imaginary_bank_locator/core/repositories/maps_respitory.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_provider.dart';
import 'package:imaginary_bank_locator/providers/Maps/location_state.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> repositoryProviders = [
  Provider<MapsRepository>(
    create: (_) => MapsRepository(),
  ),
];

List<SingleChildWidget> stateNotifierProviders = [
  StateNotifierProvider<MapsProvider, LocationState>(
    create: (_) => MapsProvider(),
  ),
];
