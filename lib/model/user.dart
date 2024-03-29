import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tempoloco/model/utils.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
class User {
  @CopyWithField(immutable: true)
  String uid;
  String username;
  String email;
  @CopyWithField(immutable: true)
  @JsonKey(toJson: dateTimetoJson, fromJson: dateTimefromJson)
  DateTime createdDate;
  int nbStars;
  int nbGames;
  bool notification;
  bool reviewed;
  bool hasCollectedStrikes;
  List<Map<String, dynamic>> history;
  @JsonKey(toJson: listDateTimetoJson, fromJson: listDateTimefromJson)
  List<DateTime> strikes;
  List<String> favorites;
  List<String> library;
  List<Map<String, dynamic>> highscores;
  List<Map<String, String>> artists;
  List<String> friends;
  // TODO: Create another collection
  List<String> friendRequests;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.createdDate,
    this.nbStars = 10,
    this.nbGames = 0,
    this.notification = true,
    this.reviewed = false,
    this.hasCollectedStrikes = false,
    this.history = const <Map<String, dynamic>>[],
    this.strikes = const <DateTime>[],
    this.favorites = const <String>[],
    this.library = const <String>[],
    this.highscores = const <Map<String, dynamic>>[],
    this.artists = const <Map<String, String>>[],
    this.friends = const <String>[],
    this.friendRequests = const <String>[],
  });

  factory User.fromJson(Map<String, dynamic> data, String uid) =>
      _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => toJson().toString();
}
