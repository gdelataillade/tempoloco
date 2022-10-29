import 'package:cloud_firestore/cloud_firestore.dart';

DateTime dateTimefromJson(Timestamp? date) =>
    DateTime.fromMillisecondsSinceEpoch(
        date != null ? date.millisecondsSinceEpoch : 0);

Timestamp dateTimetoJson(DateTime date) =>
    Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

List<Timestamp> listDateTimetoJson(List<DateTime> listDate) => listDate
    .map((e) => Timestamp.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch))
    .toList();

List<DateTime> listDateTimefromJson(List<dynamic> lists) => lists.map((e) {
      if (e is Timestamp) {
        return DateTime.fromMillisecondsSinceEpoch(e.millisecondsSinceEpoch);
      }
      return DateTime.fromMillisecondsSinceEpoch(0);
    }).toList();

Duration durationfromJson(int duration) => duration < 100000
    ? Duration(seconds: duration)
    : Duration(microseconds: duration);
int durationtoJson(Duration duration) => duration.inMicroseconds;
