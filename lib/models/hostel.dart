import 'package:cloud_firestore/cloud_firestore.dart';

class Hostel {
  static const directory = "hostels";

  static const hostelName = "hostelName";
  static const hostelLocation = "location";
  static const hostelPrizeRange = "prize_range";

  String? _name;
  String? _location;
  double? _prizeRange;

  String get name => _name ?? "Hostel Name";
  String get location => _location ?? "Hostel Location";
  double get priceRange => _prizeRange ?? 5000;

  Hostel.fromSnapshot(DocumentSnapshot snap) {
    Map pp = snap.data() as Map;

    _name = pp[hostelName];
    _location = pp[hostelLocation];
    _prizeRange = pp[hostelPrizeRange];
  }
}
