import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<Map<String, double>> getLatLongFromZipCode(String zipCode) async {
    try {
      List<Location> locations = await locationFromAddress(zipCode);
      if (locations.isNotEmpty) {
        return {
          'latitude': locations.first.latitude,
          'longitude': locations.first.longitude,
        };
      } else {
        throw Exception('No locations found');
      }
    } catch (e) {
      throw Exception('Failed to fetch coordinates: $e');
    }
  }
}
