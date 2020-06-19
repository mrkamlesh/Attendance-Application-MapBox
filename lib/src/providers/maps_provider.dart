import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class MapsProvider extends ChangeNotifier {
  Position _currentPosition;
  Position get currentPosition => _currentPosition;

  Future<void> getCurrentPosition() async {
    try {
      Position lastPosition = await Geolocator().getLastKnownPosition();
      if (lastPosition != null) {
        print("Success Get Last Position...");
        _currentPosition = lastPosition;
      } else {
        print("Failed Get Last Position...");
        //TODO Bug Mendapatkan Current Position
        final currentPosition =
            await Geolocator().getCurrentPosition().timeout(Duration(seconds: 15));
        if (currentPosition != null) {
          print("Success Get Your Current Position...");
          _currentPosition = currentPosition;
        } else {
          print("Failed Get Your Current Position...");
          throw "Can't Get Your Position";
        }
      }
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }

  void setTrackingLocation(Position position) {
    _currentPosition = position;
    notifyListeners();
  }

  MapPosition _cameraPosition;
  MapPosition get cameraPosition => _cameraPosition;

  void setTrackingCameraPosition(MapPosition value) {
    _cameraPosition = value;
    notifyListeners();
  }
}