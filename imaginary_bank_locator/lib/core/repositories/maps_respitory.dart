import 'package:imaginary_bank_locator/common/http.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';

import '../../environment_config.dart';

class MapsRepository with Http {
  Future<List<MapsData>> getLocationData() async {
    final response = await get(
      '${EnvironmentConfig.api_url}',
    );
    var entities = response["data"] as List<dynamic>;
    var items = <MapsData>[];
    entities.forEach((entity) {
      items.add(
        MapsData.fromMap(entity),
      );
    });
    return items;
  }
}
