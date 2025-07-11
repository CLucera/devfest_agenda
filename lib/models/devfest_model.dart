import 'package:latlong2/latlong.dart';

class DevfestModel {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String name;
  final String? url;
  final String? callForPaperUrl;

  final LatLng location;

  DevfestModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.location,
    this.url,
    this.callForPaperUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'name': name,
      'url': url,
      'callForPaperUrl': callForPaperUrl,
    };
  }
}

final List<DevfestModel> italianDevfests = [
  DevfestModel(
    id: "1",
    startTime: DateTime(2024, 6, 1),
    endTime: DateTime(2024, 6, 1),
    name: "Devfest Pisa",
    url: null,
    callForPaperUrl: "https://devfest.gdgpisa.it/",
    location: const LatLng(43.7167, 10.4000),
  ),
  DevfestModel(
      id: "13",
      startTime: DateTime(2024, 7, 27),
      endTime: DateTime(2024, 7, 27),
      name: "Devfest Vicenza",
      url: null,
      callForPaperUrl: null,
      location: const LatLng(45.5467, 11.5467)),
  DevfestModel(
      id: "2",
      startTime: DateTime(2024, 9, 21),
      endTime: DateTime(2024, 9, 21),
      name: "Devfest Campobasso",
      url: null,
      callForPaperUrl: null,
      location: const LatLng(41.5581, 14.6628)),
  DevfestModel(
    id: "3",
    startTime: DateTime(2024, 10, 5),
    endTime: DateTime(2024, 10, 5),
    name: "DevFest Napoli",
    url: null,
    callForPaperUrl:
    "https://conference-hall.io/public/event/PHHK4EptNATs2FNbqEPl",
    location: const LatLng(40.8518, 14.2681),
  ),
  DevfestModel(
    id: "4",
    startTime: DateTime(2024, 10, 5),
    endTime: DateTime(2024, 10, 5),
    name: "DevFest Modena",
    url: "devfest.modena.it",
    callForPaperUrl: null,
    location: const LatLng(44.6467, 10.9333),
  ),
  DevfestModel(
    id: "5",
    startTime: DateTime(2024, 10, 18),
    endTime: DateTime(2024, 10, 19),
    name: "Devfest Alps",
    url: null,
    callForPaperUrl: "https://buff.ly/3VF4qyg",
    location: const LatLng(45.0703, 7.6869),
  ),
  DevfestModel(
    id: "6",
    startTime: DateTime(2024, 10, 26),
    endTime: DateTime(2024, 10, 26),
    name: "DevFest Trento ",
    url: null,
    callForPaperUrl: "https://forms.gle/4dLYepwnvxrqpxGz9",
    location: const LatLng(46.0667, 11.1167),
  ),
  DevfestModel(
    id: "7",
    startTime: DateTime(2024, 10, 26),
    endTime: DateTime(2024, 10, 26),
    name: "DevFest Bari",
    url: "https://bari.devfest.it/ ",
    callForPaperUrl: "https://sessionize.com/devfestbari-2024/",
    location: const LatLng(41.1253, 16.8667),
  ),
  DevfestModel(
    id: "8",
    startTime: DateTime(2024, 11, 8),
    endTime: DateTime(2024, 11, 10),
    name: "DevFest Pescara",
    url: null,
    callForPaperUrl: "https://sessionize.com/devfest-pescara-2024/",
    location: const LatLng(42.4647, 14.2142),
  ),
  DevfestModel(
    id: "9",
    startTime: DateTime(2024, 11, 16),
    endTime: DateTime(2024, 11, 16),
    name: "Devfest Venezia",
    url: null,
    callForPaperUrl: null,
    location: const LatLng(45.4408, 12.3155),
  ),
  DevfestModel(
    id: "10",
    startTime: DateTime(2024, 11, 16),
    endTime: DateTime(2024, 11, 17),
    name: "Devfest Catania",
    url: null,
    callForPaperUrl: "https://sessionize.com/devfest-catania-2024/",
    location: const LatLng(37.5079, 15.0830),
  ),
  DevfestModel(
    id: "11",
    startTime: DateTime(2024, 11, 23),
    endTime: DateTime(2024, 11, 23),
    name: "Devfest Milano",
    url: "https://devfestmilano.it/",
    callForPaperUrl: "https://sessionize.com/devfest-milano-2024/",
    location: const LatLng(45.4642, 9.1895),
  ),
  DevfestModel(
    id: "12",
    startTime: DateTime(2024, 11, 30),
    endTime: DateTime(2024, 11, 30),
    name: "Devfest Basilicata",
    url: null,
    callForPaperUrl: null,
    location: const LatLng(40.6395, 15.8051),
  ),
];


final List<DevfestModel> hatDevfest = [
  DevfestModel(
      id: "13",
      startTime: DateTime(2024, 7, 27),
      endTime: DateTime(2024, 7, 27),
      name: "Vicenza",
      url: null,
      callForPaperUrl: null,
      location: const LatLng(45.5467, 11.5467)),
  DevfestModel(
      id: "2",
      startTime: DateTime(2024, 9, 21),
      endTime: DateTime(2024, 9, 21),
      name: "Campobasso",
      url: null,
      callForPaperUrl: null,
      location: const LatLng(41.5581, 14.6628)),
  DevfestModel(
    id: "3",
    startTime: DateTime(2024, 10, 5),
    endTime: DateTime(2024, 10, 5),
    name: "Napoli",
    url: null,
    callForPaperUrl:
    "https://conference-hall.io/public/event/PHHK4EptNATs2FNbqEPl",
    location: const LatLng(40.8518, 14.2681),
  ),
  DevfestModel(
    id: "4",
    startTime: DateTime(2024, 10, 5),
    endTime: DateTime(2024, 10, 5),
    name: "Modena",
    url: "devfest.modena.it",
    callForPaperUrl: null,
    location: const LatLng(44.6467, 10.9333),
  ),
  DevfestModel(
    id: "5",
    startTime: DateTime(2024, 10, 18),
    endTime: DateTime(2024, 10, 19),
    name: "Alps",
    url: null,
    callForPaperUrl: "https://buff.ly/3VF4qyg",
    location: const LatLng(45.0703, 7.6869),
  ),
  DevfestModel(
    id: "6",
    startTime: DateTime(2024, 10, 26),
    endTime: DateTime(2024, 10, 26),
    name: "Trento ",
    url: null,
    callForPaperUrl: "https://forms.gle/4dLYepwnvxrqpxGz9",
    location: const LatLng(46.0667, 11.1167),
  ),
  DevfestModel(
    id: "8",
    startTime: DateTime(2024, 11, 8),
    endTime: DateTime(2024, 11, 10),
    name: "Pescara",
    url: null,
    callForPaperUrl: "https://sessionize.com/devfest-pescara-2024/",
    location: const LatLng(42.4647, 14.2142),
  ),
  DevfestModel(
    id: "10",
    startTime: DateTime(2024, 11, 16),
    endTime: DateTime(2024, 11, 17),
    name: "Catania",
    url: null,
    callForPaperUrl: "https://sessionize.com/devfest-catania-2024/",
    location: const LatLng(37.5079, 15.0830),
  ),
  DevfestModel(
    id: "11",
    startTime: DateTime(2024, 11, 23),
    endTime: DateTime(2024, 11, 23),
    name: "Milano",
    url: "https://devfestmilano.it/",
    callForPaperUrl: "https://sessionize.com/devfest-milano-2024/",
    location: const LatLng(45.4642, 9.1895),
  ),
  DevfestModel(
    id: "12",
    startTime: DateTime(2024, 11, 30),
    endTime: DateTime(2024, 11, 30),
    name: "Basilicata",
    url: null,
    callForPaperUrl: null,
    location: const LatLng(40.6395, 15.8051),
  ),
];

Map<String, Object?> devfestModelsToMap(List<DevfestModel> models) {
  Map<String, Object?> devfestModelMap = {};

  for (var model in models) {
    devfestModelMap[model.id] = model.toJson();
  }

  return devfestModelMap;
}

class TestModel {
  final String id;
  final DateTime date;
  final String name;
  final String? url;

  TestModel({
    required this.id,
    required this.date,
    required this.name,
    this.url,
  });
}
