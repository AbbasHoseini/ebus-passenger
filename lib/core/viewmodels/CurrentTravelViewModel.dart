import 'dart:convert';

import 'package:ebus/core/models/CurrentTravel.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class CurrentTravelViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  CurrentTravelViewModel({this.authServiceType});
  Location _location = Location();
  var _webService;

  // CurrentTravel? _currentTravel;
  CurrentTravel? _currentTravel = CurrentTravel();
  bool _isLoaded = false;
  bool _isInternetOff = false;
  MapController _mapController = MapController();
  List<Marker> _markers = <Marker>[];
  List<LatLng> _latLngs = <LatLng>[];
  Marker _userMarker =
      Marker(builder: (context) => Container(), point: LatLng(35, 48));
  bool _isFirst = true;
  bool get isFirst => _isFirst;

  CurrentTravel get currentTravel => _currentTravel!;
  bool get isLoaded => _isLoaded;
  bool get isInternetOff => _isInternetOff;
  MapController get mapController => _mapController;
  List<Marker> get markers => _markers;
  List<LatLng> get latLngs => _latLngs;
  Marker get userMarker => _userMarker;

  Future getUserCurrentTravel(bool isBeforeBuild) async {
    _isLoaded = false;
    _isInternetOff = false;
    if (!isBeforeBuild) notifyListeners();

    _webService = authServiceType == AuthServiceType.real
        ? Webservice()
        : MockWebservice();
    CurrentTravel? currentTravel;
    http.Response response = await _webService.getUserCurrentTravel(_isFirst);
    print('reeeeeeeeeeeeeeeeeeeeeeeeeeeesponse:::: ${response.body}');
    if (response.body != 'null') {
      var jr = jsonDecode(response.body);
      var data;
      int status = response.statusCode;
      try {
        data = jr['data'];
      } catch (e) {
        data = jr['Data'];
      }
      if ((status == 200 || status == 201) && data.length > 0) {
        final Iterable json = data;
        // currentTravel = CurrentTravel.fromJson(json);
        currentTravel =
            json.map((item) => CurrentTravel.fromJson(item)).toList().first;
        print('000000000000000000000000000 $_currentTravel');
        _currentTravel = currentTravel;
        if (_currentTravel!.srcLat != null &&
            _currentTravel!.srcLon != null &&
            _currentTravel!.destLat != null &&
            _currentTravel!.destLon != null) {
          _addMarkers();
        }
        _isInternetOff = false;
        _isLoaded = true;
        if (!isBeforeBuild) notifyListeners();
      } else {
        _isInternetOff = false;
        _isLoaded = true;
        if (!isBeforeBuild) notifyListeners();
      }
    } else {
      _isInternetOff = true;
      _isLoaded = false;
      if (!isBeforeBuild) notifyListeners();
    }
    print('after getUserTravel isLoaded = $_isLoaded');
    print('object $currentTravel');
    return currentTravel;
  }

  void _addMarkers() {
    _latLngs = [
      LatLng(_currentTravel!.srcLat!, _currentTravel!.srcLon!),
      LatLng(_currentTravel!.destLat!, _currentTravel!.destLon!)
    ];
    _markers = [
      Marker(
        anchorPos: AnchorPos.exactly(Anchor(25, -25)),
        point: LatLng(_currentTravel!.srcLat!, _currentTravel!.srcLon!),
        builder: (ctx) => const Icon(
          Icons.outlined_flag,
          size: 35,
          color: colorPrimary,
        ),
      ),
      Marker(
        anchorPos: AnchorPos.exactly(Anchor(25, -25)),
        point: LatLng(_currentTravel!.destLat!, _currentTravel!.destLon!),
        builder: (ctx) => const Icon(
          Icons.flag,
          size: 35,
          color: colorPrimary,
        ),
      ),
    ];
  }

  void getUserLocation(bool setOnChange) async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();
    _userMarker = Marker(
      anchorPos: AnchorPos.exactly(Anchor(25, -25)),
      point: LatLng(_locationData.latitude!, _locationData.longitude!),
      builder: (ctx) => const Icon(
        Icons.person_pin_circle,
        size: 35,
        color: colorPrimary,
      ),
    );
    // _mapController.move(
    //     LatLng(_locationData.latitude, _locationData.longitude), 14.0);

    _mapController.fitBounds(
        LatLngBounds.fromPoints(_latLngs + [_userMarker.point]),
        options: const FitBoundsOptions(
            padding:
                EdgeInsets.only(left: 52, right: 32, bottom: 24, top: 64)));
    notifyListeners();
  }

  String convertToBase64(String qrcode) {
    return qrcode.replaceAll('\n', '');
  }

  void initiate(BuildContext context) {
    _mapController = MapController();
  }
}
