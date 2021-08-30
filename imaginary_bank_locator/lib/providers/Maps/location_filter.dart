import 'package:flutter/foundation.dart';

class LocationFilter {
  final String text;
 

  LocationFilter({
    @required this.text,
  
  });

  LocationFilter copyWith({
    String text,
    }) {
    return LocationFilter(
        text: text ?? this.text,
       );
  }
}

class LocationInitialFilter extends LocationFilter {
  LocationInitialFilter()
      : super(
          text: null,
        
        );
}