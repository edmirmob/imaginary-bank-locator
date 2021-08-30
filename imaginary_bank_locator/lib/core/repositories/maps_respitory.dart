import 'package:imaginary_bank_locator/common/http.dart';
import 'package:imaginary_bank_locator/core/models/maps.dart';

import '../../environment_config.dart';

class MapsRepository with Http {
  Future<List<MapsData>> getLocationData(String name,) async {
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
    List search= <MapsData>[];
    if(name!=''){
  if(name!=null ){
    
 search.addAll(items.where((element) => element.name.toUpperCase().startsWith(name.toUpperCase()) || element.address.toUpperCase().startsWith(name.toUpperCase()))); 
  }
  } 

    return search==[] ||  name==null || name=='' ? items:search;
  }
}
