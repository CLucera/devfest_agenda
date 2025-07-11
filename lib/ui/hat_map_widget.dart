import 'dart:ui';

import 'package:devfest_agenda/main.dart';
import 'package:devfest_agenda/models/devfest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api_keys.dart';

const styleUrl =
    "https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg";

const googleColors = [
  Color(0xFF4285F4),
  Color(0xFFF4B400),
  Color(0xFF0F9D58),
];
const selectedColor = Color(0xFFDB4437);
const currentIndex = 9;

class HatMapWidget extends StatefulWidget {
  const HatMapWidget({super.key});

  @override
  _HatMapWidgetState createState() => _HatMapWidgetState();
}

class _HatMapWidgetState extends State<HatMapWidget>
    with TickerProviderStateMixin {
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
    final current = appNotifier.hatDevfests[currentIndex];
    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(4),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: const LatLng(41.90, 12.49),
              initialCameraFit: _getFitForDevfests(appNotifier.devfests),
            ),
            children: [
              TileLayer(
                urlTemplate: "$styleUrl?api_key={api_key}",
                additionalOptions: const {"api_key": kMapApiKey},
                maxZoom: 20,
                maxNativeZoom: 20,
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
              PolylineLayer(
                polylines: [
                  for (int i = 0; i < appNotifier.hatDevfests.length; i++)
                    getPolyLineAtIndex(i),
                  getPolyLineAtIndex(currentIndex),
                ],
              ),
              MarkerLayer(
                markers: [
                  for (int i = 0; i < appNotifier.hatDevfests.length; i++)
                    getMarkerAtIndex(i),
                  Marker(
                    point: getCenter(getCoordinatesAtIndex(currentIndex)),
                    child: Image.network('assets/plane_hat.png'),
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Next Stop: ${current.name} - ${DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(current.startTime)}",
                  style: GoogleFonts.eduNswActFoundation(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    shadows: <Shadow>[
                      for(int i = 0; i < 10; i++)
                      const Shadow(
                        offset: Offset.zero,
                        blurRadius: 3.0,
                        color: Colors.white,
                      ),
                    ],),
                ),
                const SizedBox(height: 10,),
                Stack(
                  children: [
                    LinearProgressIndicator(
                      minHeight: 40,
                      color: Colors.amber,
                      value: currentIndex / (appNotifier.hatDevfests.length - 1),
                    ),
                    Align(
                      alignment: Alignment(
                        lerpDouble(
                                -1.05,
                                1.05,
                                currentIndex /
                                    (appNotifier.hatDevfests.length - 1)) ??
                            0,
                        0,
                      ),
                      child: Transform.scale(
                        scaleX: -1,
                        child: Transform.translate(
                          offset: const Offset(0, -5),
                          child: Transform.rotate(
                            angle: degToRadian(20),
                            child: Image.network(
                              'assets/plane_hat.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Polyline getPolyLineAtIndex(int index) {
    final coordinates = getCoordinatesAtIndex(index);
    return Polyline(
      points: [
        coordinates.first,
        coordinates.second,
      ],
      color: (index > currentIndex
              ? Colors.grey
              : index == currentIndex
                  ? selectedColor
                  : googleColors[index % googleColors.length])
          .withValues(alpha: index == currentIndex ? 1 : 0.8),
      strokeWidth: index == currentIndex ? 8 : 5,
      pattern: index == currentIndex
          ? const StrokePattern.solid()
          : const StrokePattern.dotted(),
    );
  }

  ({LatLng first, LatLng second}) getCoordinatesAtIndex(int index) {
    LatLng first = const LatLng(38.116669, 13.366667);
    // LatLng first = index == 0
    //     ? const LatLng(38.116669, 13.366667)
    //     : appNotifier.carloDevfests[index - 1].location;
    LatLng second = appNotifier.hatDevfests[index].location;
    return (
      first: first,
      second: second,
    );
  }

  Marker getMarkerAtIndex(int index) {
    final item = appNotifier.hatDevfests[index];
    return Marker(
      point: item.location,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: Card(
              shape: const StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ColorFiltered(
                  colorFilter: index <= currentIndex
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        )
                      : const ColorFilter.matrix(<double>[
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0.2126,
                          0.7152,
                          0.0722,
                          0,
                          0,
                          0,
                          0,
                          0,
                          1,
                          0,
                        ]),
                  child: Image.network(
                    'assets/gdg.png',
                  ),
                ),
              ),
            ),
          ),
          Text(
            item.name,
            style: GoogleFonts.eduNswActFoundation(
                fontSize: 14, fontWeight: FontWeight.w600),
          )
        ],
      ),
      width: 100,
      height: 80,
    );
  }

  LatLng getCenter(({LatLng first, LatLng second}) points) {
    return LatLngTween(
      begin: points.first,
      end: points.second,
    ).lerp(0.5);
  }
}
