import 'package:devfest_agenda/main.dart';
import 'package:devfest_agenda/models/devfest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    appNotifier.addListener(() {
      if (appNotifier.selectedDevfests.isEmpty) {
        controller.animatedFitCamera(
          cameraFit: _getFitForDevfests(appNotifier.devfests),
        );
      } else {
        controller.animatedFitCamera(
          cameraFit: _getFitForDevfests(appNotifier.selectedDevfests),
        );
      }
      setState(() {});
    });
  }

  CameraFit _getFitForDevfests(List<DevfestModel> devfests) {
    return CameraFit.coordinates(
      coordinates: devfests.map((e) => e.location).toList(),
      padding: const EdgeInsets.all(100),
      minZoom: 5,
      maxZoom: 10,
    );
  }

  late final controller = AnimatedMapController(vsync: this);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(4),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          initialCenter: const LatLng(41.90, 12.49),
          initialCameraFit: _getFitForDevfests(appNotifier.devfests),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.hatdroid.devfest_agenda',
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
          MarkerLayer(
              markers: (appNotifier.selectedDevfests.isEmpty
                      ? appNotifier.devfests
                      : appNotifier.selectedDevfests)
                  .map(
            (e) {
              return Marker(
                point: e.location,
                child: Card(
                  shape: const StadiumBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'assets/gdg.png'
                    ),
                  ),
                ),
                width: 50,
                height: 50,
              );
            },
          ).toList())
        ],
      ),
    );
  }
}
