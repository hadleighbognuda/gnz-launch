import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/flight_registration.dart';

class FlightProvider with ChangeNotifier {
  List<FlightRegistration> _registrations = [];
  FlightRegistration _currentRegistration = FlightRegistration(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    towPlaneRegistration: '',
    towPlanePilotName: '',
    gliderRegistration: '',
    primaryPilotID: '',
    registrationDate: DateTime.now(),
  );

  List<FlightRegistration> get registrations => _registrations;
  FlightRegistration get currentRegistration => _currentRegistration;

  void updateCurrentRegistration({
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
    _currentRegistration = _currentRegistration.copyWith(
      towPlaneRegistration: towPlaneRegistration,
      towPlanePilotName: towPlanePilotName,
      gliderRegistration: gliderRegistration,
      primaryPilotID: primaryPilotID,
      secondaryPilotID: secondaryPilotID,
      takeoffLatitude: takeoffLatitude,
      takeoffLongitude: takeoffLongitude,
      landingLatitude: landingLatitude,
      landingLongitude: landingLongitude,
      takeoffLocation: takeoffLocation,
      landingLocation: landingLocation,
      flightDistance: flightDistance,
      flightPath: flightPath,
    );
    notifyListeners();
  }

  void addRegistration() {
    if (_currentRegistration.isValid && _currentRegistration.isValidSecondaryPilot) {
      _registrations.add(_currentRegistration);
      _clearCurrentRegistration();
      _saveRegistrations();
      notifyListeners();
    }
  }

  void _clearCurrentRegistration() {
    _currentRegistration = FlightRegistration(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      towPlaneRegistration: '',
      towPlanePilotName: '',
      gliderRegistration: '',
      primaryPilotID: '',
      registrationDate: DateTime.now(),
    );
  }

  void clearCurrentRegistration() {
    _clearCurrentRegistration();
    notifyListeners();
  }

  Future<void> _saveRegistrations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final registrationsJson = _registrations.map((r) => r.toJson()).toList();
      await prefs.setString('registrations', jsonEncode(registrationsJson));
      if (kDebugMode) {
        print('Saved ${_registrations.length} registrations');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving registrations: $e');
      }
    }
  }

  Future<void> loadRegistrations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final registrationsString = prefs.getString('registrations');
      if (registrationsString != null) {
        final List<dynamic> registrationsJson = jsonDecode(registrationsString);
        _registrations = registrationsJson
            .map((json) => FlightRegistration.fromJson(json))
            .toList();
        notifyListeners();
        if (kDebugMode) {
          print('Loaded ${_registrations.length} registrations');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading registrations: $e');
      }
    }
  }

  void deleteRegistration(String id) {
    _registrations.removeWhere((registration) => registration.id == id);
    _saveRegistrations();
    notifyListeners();
  }

  List<FlightRegistration> getRecentRegistrations({int limit = 5}) {
    final sortedRegistrations = List<FlightRegistration>.from(_registrations);
    sortedRegistrations.sort((a, b) => b.registrationDate.compareTo(a.registrationDate));
    return sortedRegistrations.take(limit).toList();
  }
}
