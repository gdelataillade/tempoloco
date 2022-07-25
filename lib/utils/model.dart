import 'package:cloud_firestore/cloud_firestore.dart';

DateTime dateTimefromJson(Timestamp? date) =>
    DateTime.fromMillisecondsSinceEpoch(
        date != null ? date.millisecondsSinceEpoch : 0);

Timestamp dateTimetoJson(DateTime date) =>
    Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

DateTime? dateTimefromJsonWithNull(Timestamp? date) => date == null
    ? null
    : DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

Timestamp? dateTimetoJsonWithNull(DateTime? date) => date == null
    ? null
    : Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch);

// seconds = microseconds ÷ 1,000,000
Duration durationfromJson(int duration) => duration < 100000
    ? Duration(seconds: duration)
    : Duration(microseconds: duration);
int durationtoJson(Duration duration) => duration.inMicroseconds;
