import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:latlong2/latlong.dart';
import 'package:carzoum/carzoum.dart';

class MapLocationPage extends StatelessWidget {
  const MapLocationPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MapLocationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Map Location",
        actions: [],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(4.158115, 9.283552),
          zoom: 13,
        ),
        // layers: [
        //   TileLayerOptions(
        //     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        //     subdomains: ['a', 'b', 'c'],
        //   ),
        //   MarkerLayerOptions(
        //     markers: [
        //       Marker(
        //         point: LatLng(4.158115, 9.283552),
        //         builder: (context) {
        //           return Icon(
        //             Icons.pin_drop,
        //             size: 30.sp,
        //             color: primaryColor,
        //           );
        //         },
        //       )
        //     ],
        //   ),
        // ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(4.158115, 9.283552),
                builder: (context) {
                  return Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: primaryColor,
                  );
                },
              ),
              Marker(
                point: LatLng(4.161034, 9.280174),
                builder: (context) {
                  return Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: primaryColor,
                  );
                },
              ),
              Marker(
                point: LatLng(4.157578, 9.285928),
                builder: (context) {
                  return Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: primaryColor,
                  );
                },
              ),
              Marker(
                point: LatLng(4.157578, 9.289928),
                builder: (context) {
                  return Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: primaryColor,
                  );
                },
              ),
              Marker(
                point: LatLng(4.157578, 9.299928),
                builder: (context) {
                  return Icon(
                    Icons.location_on,
                    size: 20.sp,
                    color: primaryColor,
                  );
                },
              ),
            ],
          ),
          // PolylineLayer(
          //   polylineCulling: false,
          //   polylines: [
          //     Polyline(
          //       points: [
          //         LatLng(4.158115, 9.283552),
          //         LatLng(4.158115, 8.283552),
          //       ],
          //       color: Colors.blue,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
