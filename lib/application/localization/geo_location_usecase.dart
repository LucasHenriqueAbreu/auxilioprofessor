import 'dart:async';

import 'package:auxilioprofessor/core/base/errors/localization_not_found_exception.dart';
import 'package:auxilioprofessor/core/base/usecase/usecase_base.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationUsecase extends UsecaseBaseWithOutInput<Localization> {
  @override
  Future<Localization> execute() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocalizationNotFoundException('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocalizationNotFoundException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocalizationNotFoundException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final result = await Geolocator.getCurrentPosition();
    return Localization(latitude: result.latitude, longitude: result.longitude);
  }
}
