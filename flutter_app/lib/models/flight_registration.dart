import 'dart:convert';

class FlightRegistration {
  final String id;
  final String towPlaneRegistration;
  final String towPlanePilotName;
  final String gliderRegistration;
  final String primaryPilotID;
  final String? secondaryPilotID;
  final DateTime registrationDate;
  final double? takeoffLatitude;
  final double? takeoffLongitude;
  final double? landingLatitude;
  final double? landingLongitude;
  final String? takeoffLocation;
  final String? landingLocation;
  final double? flightDistance; // in meters
  final List<Map<String, double>>? flightPath; // GPS track points

  FlightRegistration({
    required this.id,
    required this.towPlaneRegistration,
    required this.towPlanePilotName,
    required this.gliderRegistration,
    required this.primaryPilotID,
    this.secondaryPilotID,
    required this.registrationDate,
    this.takeoffLatitude,
    this.takeoffLongitude,
    this.landingLatitude,
    this.landingLongitude,
    this.takeoffLocation,
    this.landingLocation,
    this.flightDistance,
    this.flightPath,
  });

  bool get isValid {
    return towPlaneRegistration.isNotEmpty &&
           towPlanePilotName.isNotEmpty &&
           gliderRegistration.isNotEmpty &&
           _isValidPilotID(primaryPilotID);
  }

  bool get isValidSecondaryPilot {
    if (secondaryPilotID == null || secondaryPilotID!.isEmpty) {
      return true;
    }
    return _isValidPilotID(secondaryPilotID!);
  }

  bool _isValidPilotID(String pilotID) {
    return pilotID.length == 4 && RegExp(r'^\d{4}$').hasMatch(pilotID);
  }

  String get formattedDate {
    return '${registrationDate.day}/${registrationDate.month}/${registrationDate.year} ${registrationDate.hour}:${registrationDate.minute.toString().padLeft(2, '0')}';
  }

  String get locationSummary {
    if (takeoffLocation != null && landingLocation != null) {
      return '$takeoffLocation → $landingLocation';
    } else if (takeoffLatitude != null && takeoffLongitude != null) {
      return 'Lat: ${takeoffLatitude!.toStringAsFixed(4)}, Lng: ${takeoffLongitude!.toStringAsFixed(4)}';
    }
    return 'Location not recorded';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'towPlaneRegistration': towPlaneRegistration,
      'towPlanePilotName': towPlanePilotName,
      'gliderRegistration': gliderRegistration,
      'primaryPilotID': primaryPilotID,
      'secondaryPilotID': secondaryPilotID,
      'registrationDate': registrationDate.toIso8601String(),
      'takeoffLatitude': takeoffLatitude,
      'takeoffLongitude': takeoffLongitude,
      'landingLatitude': landingLatitude,
      'landingLongitude': landingLongitude,
      'takeoffLocation': takeoffLocation,
      'landingLocation': landingLocation,
      'flightDistance': flightDistance,
      'flightPath': flightPath,
    };
  }

  factory FlightRegistration.fromJson(Map<String, dynamic> json) {
    return FlightRegistration(
      id: json['id'],
      towPlaneRegistration: json['towPlaneRegistration'],
      towPlanePilotName: json['towPlanePilotName'],
      gliderRegistration: json['gliderRegistration'],
      primaryPilotID: json['primaryPilotID'],
      secondaryPilotID: json['secondaryPilotID'],
      registrationDate: DateTime.parse(json['registrationDate']),
      takeoffLatitude: json['takeoffLatitude']?.toDouble(),
      takeoffLongitude: json['takeoffLongitude']?.toDouble(),
      landingLatitude: json['landingLatitude']?.toDouble(),
      landingLongitude: json['landingLongitude']?.toDouble(),
      takeoffLocation: json['takeoffLocation'],
      landingLocation: json['landingLocation'],
      flightDistance: json['flightDistance']?.toDouble(),
      flightPath: json['flightPath'] != null 
          ? List<Map<String, double>>.from(
              json['flightPath'].map((point) => Map<String, double>.from(point))
            )
          : null,
    );
  }

  FlightRegistration copyWith({
    String? towPlaneRegistration,
    String? towPlanePilotName,
    String? gliderRegistration,
    String? primaryPilotID,
    String? secondaryPilotID,
    double? takeoffLatitude,
    double? takeoffLongitude,
    double? landingLatitude,
    double? landingLongitude,
    String? takeoffLocation,
    String? landingLocation,
    double? flightDistance,
    List<Map<String, double>>? flightPath,
  }) {
    return FlightRegistration(
      id: id,
      towPlaneRegistration: towPlaneRegistration ?? this.towPlaneRegistration,
      towPlanePilotName: towPlanePilotName ?? this.towPlanePilotName,
      gliderRegistration: gliderRegistration ?? this.gliderRegistration,
      primaryPilotID: primaryPilotID ?? this.primaryPilotID,
      secondaryPilotID: secondaryPilotID ?? this.secondaryPilotID,
      registrationDate: registrationDate,
      takeoffLatitude: takeoffLatitude ?? this.takeoffLatitude,
      takeoffLongitude: takeoffLongitude ?? this.takeoffLongitude,
      landingLatitude: landingLatitude ?? this.landingLatitude,
      landingLongitude: landingLongitude ?? this.landingLongitude,
      takeoffLocation: takeoffLocation ?? this.takeoffLocation,
      landingLocation: landingLocation ?? this.landingLocation,
      flightDistance: flightDistance ?? this.flightDistance,
      flightPath: flightPath ?? this.flightPath,
    );
  }
}
