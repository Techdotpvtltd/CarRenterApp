import 'package:beasy/models/user_model.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/screens/onboarding/enabled_location_access_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/constants.dart';
import 'map_sample.dart';

class MapWithTextField extends StatefulWidget {
  const MapWithTextField({
    super.key,
    required this.fieldText,
    required this.hintText,
    this.controller,
    this.suffixWidget,
    this.prefixWidget,
    this.onTFTap,
    this.errorText,
    this.filedId,
    this.errorCode,
    this.mapHeight,
    required this.onLocationFetched,
    this.isLocationEnabled = true,
    this.latLng,
  });

  final String fieldText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final VoidCallback? onTFTap;
  final String? errorText;
  final int? filedId;
  final int? errorCode;
  final double? mapHeight;
  final Function(UserLocation? location) onLocationFetched;
  final bool isLocationEnabled;
  final LatLng? latLng;

  @override
  State<MapWithTextField> createState() => _MapWithTextFieldState();
}

class _MapWithTextFieldState extends State<MapWithTextField> {
  bool _isLoadingLocation = false;
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    setState(() {
      _latLng = widget.latLng;
    });
  }

  Future<void> _checkForPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      await NavigationService.go(context, const EnableLocationAccessScreen());
    }
  }

  void _parseLocationFromAddress(String address) async {
    try {
      setState(() {
        _isLoadingLocation = true;
        _latLng = null;
      });

      List<Location> locations = await locationFromAddress(address);
      setState(() {
        _isLoadingLocation = false;

        final location = locations.firstOrNull;
        _parseAddressFromCoordinator(location?.latitude, location?.longitude);
        if (location != null) {
          _latLng = LatLng(location.latitude, location.longitude);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      CustomDilaogs().errorBox(message: e.toString());
      setState(() {
        _isLoadingLocation = false;
        _latLng = null;
      });
      widget.onLocationFetched(null);
    }
  }

  void _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _latLng = null;
    });
    try {
      await _checkForPermission();
      final Position position = await Geolocator.getCurrentPosition();
      await _parseAddressFromCoordinator(position.latitude, position.longitude);
      setState(() {
        _latLng = LatLng(position.latitude, position.longitude);
        _isLoadingLocation = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      widget.onLocationFetched(null);
      setState(() {
        _isLoadingLocation = false;
        widget.controller?.clear();
        _latLng = null;
      });
    }
  }

  Future<void> _parseAddressFromCoordinator(
      double? latitude, double? longitude) async {
    final List<Placemark> marks =
        await placemarkFromCoordinates(latitude ?? 0, longitude ?? 0);

    final mark = marks.firstOrNull;
    widget.onLocationFetched(
      UserLocation(
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
        address: "${mark?.street}, ${mark?.locality}, ${mark?.country}",
        city: mark?.locality,
        country: mark?.country,
        streat: mark?.street,
      ),
    );
    setState(() {
      widget.controller?.text =
          "${marks.firstOrNull?.locality ?? ""}, ${marks.firstOrNull?.country ?? ""}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitleTextField(
          controller: widget.controller,
          hintText: widget.hintText,
          fieldText: widget.fieldText,
          keyboardType: TextInputType.streetAddress,
          errorText: widget.errorText,
          fieldId: widget.filedId,
          onSubmitted: (str) => _parseLocationFromAddress(str),
          errorCode: widget.errorCode,
          suffixWidget: _isLoadingLocation
              ? const SizedBox(
                  width: 5,
                  height: 5,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: StyleGuide.primaryColor2,
                      ),
                    ),
                  ),
                )
              : Visibility(
                  visible: widget.isLocationEnabled,
                  child: InkWell(
                    onTap: () {
                      _getCurrentLocation();
                    },
                    child: const Icon(
                      Icons.location_searching,
                      color: StyleGuide.primaryColor2,
                    ),
                  ),
                ),
          onTFTap: () {},
        ),
        gapH26,
        Visibility(
          visible: _latLng != null,
          child: SizedBox(
            height: widget.mapHeight,
            child: MapSample(
              isPin: true,
              latLng: _latLng,
            ),
          ),
        ),
      ],
    );
  }
}
