import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tempoloco/utils/model.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
class User {
  String uid;
  String name;
  String email;
  @JsonKey(toJson: dateTimetoJson, fromJson: dateTimefromJson)
  DateTime createdDate;
  int nbStars;
  bool notification;
  bool reviewed;
  List<String> history;
  List<String> favorites;
  List<String> library;
  List<Map<String, int>> highscores;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdDate,
    this.nbStars = 0,
    this.notification = true,
    this.reviewed = false,
    this.history = const <String>[],
    this.favorites = const <String>[],
    this.library = const <String>[],
    this.highscores = const <Map<String, int>>[],
  });

  factory User.fromJson(Map<String, dynamic> data, String uid) =>
      _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => toJson().toString();
}
