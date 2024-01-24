import 'dart:async';

import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final bool isPin;
  const MapSample({super.key, required this.isPin, this.latLng});
  final LatLng? latLng;
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late String _mapStyle;

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/icons/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.latLng!,
                zoom: 14.4746,
              ),
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.setMapStyle(_mapStyle);
              },
            ),
            LayoutBuilder(builder: (context, BoxConstraints constraints) {
              return widget.isPin
                  ? Center(
                      child: Image.asset(
                        "assets/icons/pin2.png",
                        height: constraints.maxHeight * 0.15,
                        color: StyleGuide.primaryColor2,
                      ),
                    )
                  : const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
