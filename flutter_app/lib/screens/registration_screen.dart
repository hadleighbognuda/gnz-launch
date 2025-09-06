import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/section_header.dart';
import '../widgets/location_capture_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _towPlaneRegistrationController = TextEditingController();
  final _towPlanePilotController = TextEditingController();
  final _gliderRegistrationController = TextEditingController();
  final _primaryPilotController = TextEditingController();
  final _secondaryPilotController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentRegistration();
  }

  void _loadCurrentRegistration() {
    final flightProvider = Provider.of<FlightProvider>(context, listen: false);
    final current = flightProvider.currentRegistration;
    
    _towPlaneRegistrationController.text = current.towPlaneRegistration;
    _towPlanePilotController.text = current.towPlanePilotName;
    _gliderRegistrationController.text = current.gliderRegistration;
    _primaryPilotController.text = current.primaryPilotID;
    _secondaryPilotController.text = current.secondaryPilotID ?? '';
  }

  @override
  void dispose() {
    _towPlaneRegistrationController.dispose();
    _towPlanePilotController.dispose();
    _gliderRegistrationController.dispose();
    _primaryPilotController.dispose();
    _secondaryPilotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Flight Registration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.flight_takeoff,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Register Flight Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Tow Plane Section
              const SectionHeader(
                title: 'Tow Plane Details',
                icon: Icons.flight,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _towPlaneRegistrationController,
                      label: 'Tow Plane Registration',
                      hint: 'Enter tow plane registration (e.g., ZK-ABC)',
                      onChanged: (value) => _updateRegistration(),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _towPlanePilotController,
                      label: 'Tow Plane Pilot Name',
                      hint: 'Enter pilot\'s full name',
                      onChanged: (value) => _updateRegistration(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Glider Section
              const SectionHeader(
                title: 'Glider Details',
                icon: Icons.flight,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomTextField(
                  controller: _gliderRegistrationController,
                  label: 'Glider Registration',
                  hint: 'Enter glider registration (e.g., ZK-GLD)',
                  onChanged: (value) => _updateRegistration(),
                ),
              ),
              const SizedBox(height: 24),

              // Pilots Section
              const SectionHeader(
                title: 'Glider Pilots',
                icon: Icons.people,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _primaryPilotController,
                      label: 'Primary Pilot ID (Billing)',
                      hint: 'Enter 4-digit pilot ID',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _updateRegistration(),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _secondaryPilotController,
                      label: 'Secondary Pilot ID (Optional)',
                      hint: 'Enter 4-digit pilot ID',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _updateRegistration(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Location Section
              const SectionHeader(
                title: 'Flight Location',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              const LocationCaptureWidget(),
              const SizedBox(height: 30),

              // Action Buttons
              Consumer<FlightProvider>(
                builder: (context, flightProvider, child) {
                  final isValid = flightProvider.currentRegistration.isValid &&
                                 flightProvider.currentRegistration.isValidSecondaryPilot;
                  
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isValid ? _submitRegistration : null,
                          icon: const Icon(Icons.check_circle, size: 24),
                          label: const Text('Register Flight'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isValid ? Colors.blue : Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _clearForm,
                          icon: const Icon(Icons.clear, size: 24),
                          label: const Text('Clear Form'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _updateRegistration() {
    final flightProvider = Provider.of<FlightProvider>(context, listen: false);
    flightProvider.updateCurrentRegistration(
      towPlaneRegistration: _towPlaneRegistrationController.text,
      towPlanePilotName: _towPlanePilotController.text,
      gliderRegistration: _gliderRegistrationController.text,
      primaryPilotID: _primaryPilotController.text,
      secondaryPilotID: _secondaryPilotController.text.isEmpty 
          ? null 
          : _secondaryPilotController.text,
    );
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      final flightProvider = Provider.of<FlightProvider>(context, listen: false);
      
      if (flightProvider.currentRegistration.isValid && 
          flightProvider.currentRegistration.isValidSecondaryPilot) {
        flightProvider.addRegistration();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Flight registered successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        
        // Navigate back to home screen
        Navigator.pop(context);
      } else {
        _showErrorDialog('Please fill in all required fields with valid information.');
      }
    }
  }

  void _clearForm() {
    _towPlaneRegistrationController.clear();
    _towPlanePilotController.clear();
    _gliderRegistrationController.clear();
    _primaryPilotController.clear();
    _secondaryPilotController.clear();
    
    final flightProvider = Provider.of<FlightProvider>(context, listen: false);
    flightProvider.clearCurrentRegistration();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
