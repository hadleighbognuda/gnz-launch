import 'package:flutter/material.dart';
import '../../models/flight_registration.dart';

class RegistrationSummaryCard extends StatelessWidget {
  final FlightRegistration registration;
  final VoidCallback? onDelete;

  const RegistrationSummaryCard({
    super.key,
    required this.registration,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with tow plane and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Tow: ${registration.towPlaneRegistration}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      registration.formattedDate,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Glider registration
            Text(
              'Glider: ${registration.gliderRegistration}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            
            // Primary pilot
            Text(
              'Primary Pilot: ${registration.primaryPilotID}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            
            // Secondary pilot (if exists)
            if (registration.secondaryPilotID != null && 
                registration.secondaryPilotID!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Secondary Pilot: ${registration.secondaryPilotID}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
            
            // Location info (if available)
            if (registration.takeoffLocation != null || 
                registration.takeoffLatitude != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      registration.locationSummary,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            
            // Flight distance (if available)
            if (registration.flightDistance != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.straighten,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Distance: ${(registration.flightDistance! / 1000).toStringAsFixed(1)} km',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
            
            // Delete button
            if (onDelete != null) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
