import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as ge;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takeh_customer/Global/ChooseYesNo.dart';
// import 'package:takeh_customer/Global/ChooseYesNo.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:geocoding/geocoding.dart' as place;
// import 'package:takeh_customer/Shared/i18n.dart';
import 'package:map_picker/map_picker.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:takeh_customer/Shared/i18n.dart';

class LocationProvider extends ChangeNotifier {
  // late Driver driver;

  // late Position currentPosition;
  late Location location = Location();
  late LatLng theLocation;
  // ignore: unused_field
  Completer<GoogleMapController> controller = Completer();

  bool haveLocation = false;
  MapPickerController mapPickerController = MapPickerController();

  late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;
  // late LocationData _locationData;
  //
  late CameraPosition position;

  // placemarks
  List<place.Placemark> placemarks = [];

  getLocation(BuildContext context) async {
    _serviceEnabled = await ge.Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      var res = await chooseYesNoDialog(
        context,
        S.current.pleaseEnableLocationService,
      );

      if (res != null && res['choose'])
        _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) return getLocation(context);
    }

    ge.LocationPermission permission = await ge.Geolocator.checkPermission();

    if (permission == ge.LocationPermission.denied ||
        permission == ge.LocationPermission.deniedForever ||
        permission == ge.LocationPermission.unableToDetermine) {
      await ge.Geolocator.requestPermission();
      return getLocation(context);
    }

    await ge.Geolocator.getCurrentPosition(
            desiredAccuracy: ge.LocationAccuracy.medium)
        .then((value) {
      this.position = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 17,
      );
    });

    haveLocation = true;
    notifyListeners();
    // return _locationData;

// // // // // // // // // // // //
// // // // // // // // // // // //

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   var res = await chooseYesNoDialog(
    //     context,
    //     S.current.appNeedsAccessToYourDevicesLocation,
    //   );

    //   if (res != null && res['choose'])
    //     _permissionGranted = await location.requestPermission();

    //   if (_permissionGranted != PermissionStatus.granted)
    //     return getLocation(context);
    // }

    // // haveLocation = true;
    // // notifyListeners();

    // _locationData = await location.getLocation();

    // this.position = CameraPosition(
    //   target: LatLng(_locationData.latitude!, _locationData.longitude!),
    //   zoom: 17,
    // );

    // haveLocation = true;
    // notifyListeners();
    // return _locationData;
  }

  Future<void> animateTo(double lat, double lng) async {
    final c = await controller.future;
    final p = CameraPosition(
      target: LatLng(lat, lng),
      zoom: position.zoom,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  // // // // // // // // // //
  // // // // // // // // // //
  // Set<Marker> markers = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // List<Marker> markers = <Marker>[];

  // String startCoordinatesString = '';
  // '($startLatitude, $startLongitude)';
  // String destinationCoordinatesString = '';
  // '($destinationLatitude, $destinationLongitude)';
  // Start Location Marker
  late Marker? startMarker;
  // Destination Location Marker
  late Marker? toMarker;

  clearMarker() {
    markers = {};
    // markers = [];
    startMarker = null;
    toMarker = null;
  }

  moveTheMarker(Marker marker) {
    markers[marker.markerId] = marker;
    notifyListeners();
  }

  setStartEndMarker(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) {
    startMarker = Marker(
      markerId: MarkerId('start-location'),
      position: LatLng(fromLat, fromLong),
      infoWindow: InfoWindow(title: 'Start'),
      icon: BitmapDescriptor.defaultMarker,
    );
    //
    toMarker = Marker(
      markerId: MarkerId('end-location'),
      position: LatLng(toLat, toLong),
      infoWindow: InfoWindow(title: 'End'),
      icon: BitmapDescriptor.defaultMarker,
    );

    if (startMarker != null) markers[MarkerId('start-location')] = startMarker!;
    if (toMarker != null) markers[MarkerId('end-location')] = toMarker!;

    notifyListeners();
  }
  // // // // // // // // // //
  // // // // // // // // // //

  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  clearPolylines() {
    polylinePoints = PolylinePoints();
    polylineCoordinates = [];
    polylines = {};
    notifyListeners();
  }

  createPolylines(
    double fromLat,
    double fromLong,
    double toLat,
    double toLong,
  ) async {
    if (fromLat == 0.0 && fromLong == 0.0) return;
    if (toLat == 0.0 && toLong == 0.0) return;

    // Initializing PolylinePoints

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapKey,
      PointLatLng(fromLat, fromLong),
      PointLatLng(toLat, toLong),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('route');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;

    notifyListeners();
  }

  // double calDistance(
  //     double fromLat, double fromLong, double toLat, double toLong) {
  //   return Geolocator.distanceBetween(fromLat, fromLong, toLat, toLong);
  // }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  //
  // PolylinePoints polylinePoints = PolylinePoints();

  // String googleAPiKey = "GOOGLE API KEY";

  // Set<Marker> markers = Set(); //markers for google map
  // Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  // LatLng startLocation = LatLng(27.6683619, 85.3101895);
  // LatLng endLocation = LatLng(27.6875436, 85.2751138);

  double distance = 0.0;

  Future<double> calTheDis(double fromLatitude, double fromLongitude,
      double toLatitude, double toLongitude) async {
    List<LatLng> polylineCoordinates = [];

    if (fromLatitude == 0.0 && fromLongitude == 0.0) return 0.0;
    if (toLatitude == 0.0 && toLongitude == 0.0) return 0.0;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapKey,
      PointLatLng(fromLatitude, fromLongitude),
      PointLatLng(toLatitude, toLongitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }

    return double.parse(totalDistance.toStringAsFixed(2));
  }

  moveMarkers(Marker marker) {
    markers[marker.markerId] = marker;

    notifyListeners();
  }
}
