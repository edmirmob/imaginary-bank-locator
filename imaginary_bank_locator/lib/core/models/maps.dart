import 'package:flutter/foundation.dart';

class LocationData {
  final int id;
  final String name;
  final String address;

  final String phone;
  final String email;
  final String website;

  final String type;
  final List<WorkingHours> workingHours;
  final double lat;
  final double long;

  LocationData({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.phone,
    @required this.email,
    @required this.website,
    @required this.type,
    @required this.workingHours,
    @required this.lat,
    @required this.long,
  });

  static LocationData fromMap(Map<String, Object> data) {
    final workingHoursData = (data['working_hours'] != null
        ? data['working_hours'] as List<dynamic>
        : null);
    final locationData = (data['location'] as Map<String, Object>);
    final List<WorkingHours> workingHours = [];
    if (workingHoursData != null) {
      workingHoursData.forEach((attachmentData) {
        workingHours.add(WorkingHours.fromMap(attachmentData));
      });
    }

    return LocationData(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      phone: data['phone'],
      email: data['email'],
      website: data['website'],
      type: data['type'],
      workingHours: workingHours,
      lat: locationData['lat'],
      long: locationData['long'],
    );
  }
}

class WorkingHours {
  final int day;
  final int startHours;
  final int startMinutes;
  final int endHours;
  final int endMinutes;

  WorkingHours(
      {@required this.day,
      @required this.startHours,
      @required this.startMinutes,
      @required this.endHours,
      @required this.endMinutes});

  static WorkingHours fromMap(Map<String, Object> data) {
    return WorkingHours(
      day: data['day'],
      startHours: data['start_hours'],
      startMinutes: data['start_minutes'],
      endHours: data['end_hours'],
      endMinutes: data['end_minutes'],
    );
  }
}
