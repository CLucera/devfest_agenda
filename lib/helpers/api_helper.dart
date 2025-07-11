import 'package:devfest_agenda/models/devfest_model.dart';

Future<List<DevfestModel>> findDevfestsByDate(
    Map<String, Object?> arguments,
    ) async {

  final startDateString = arguments['startDate']?.toString();
  final endDateString = arguments['endDate']?.toString();

  final startDate = startDateString != null ? DateTime.parse(startDateString) : null;
  final endDate = endDateString != null ? DateTime.parse(endDateString) : null;

  return italianDevfests.where((e) {
    final isAfterStart = startDate == null || startDate.isBefore(e.startTime);
    final isBeforeEnd = endDate == null || endDate.isAfter(e.endTime);
    return isAfterStart && isBeforeEnd;
  }).toList();
}

Future<List<DevfestModel>> listDevfests() async {
  return italianDevfests;
}
