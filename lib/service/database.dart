import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/firestore.dart';
import 'package:tempoloco/service/locator.dart';
import 'package:tempoloco/utils/helper.dart';

class DB {
  static String? get uid => Auth.uid;

  static Future<bool> createUser(User user) async {
    try {
      await FirestoreService.instance
          .setData(path: 'user/$uid', data: user.toJson());
      debugPrint("===> [Firestore] Create user: ${user.uid}");
      return true;
    } catch (e) {
      debugPrint("===> [Firestore] Error adding user: $e");
      Helper.snack("Error saving user", e.toString());
      return false;
    }
  }

  static Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      await FirestoreService.instance.updateData(path: 'user/$uid', data: data);
      debugPrint('===> [Firestore] Update user $uid: $data');
    } catch (e) {
      debugPrint("===> [Firestore] Error updating user: $e");
    }
  }

  static Stream<User> get userStream =>
      FirestoreService.instance.documentStream(
        path: 'user/$uid',
        builder: (data, documentId) => User.fromJson(data!, documentId),
      );

  static Future<bool> checkIfDocExists() => FirestoreService.instance
      .checkIfDocExists(collectionPath: 'user', docId: Auth.uid!);

  static Future<List<spotify.Track>> getTrackListFromLibary() async {
    final tracks = <spotify.Track>[];
    final userCtrl = Get.find<UserController>();

    for (final trackId in userCtrl.user.value.library) {
      final res = await spotifyLct.getTrackById(trackId);
      tracks.add(res);
    }
    debugPrint('===> [Spotify] Fetched ${tracks.length} tracks');
    return tracks;
  }

  static Future<List<spotify.Artist>> getArtistListFromLibary() async {
    final artists = <spotify.Artist>[];
    final userCtrl = Get.find<UserController>();
    final artistsId = <String>[];

    for (int i = 0; i < userCtrl.user.value.artists.length; i++) {
      final id = userCtrl.user.value.artists[i]["artist"];
      if (!artistsId.contains(id)) artistsId.add(id!);
    }

    for (final id in artistsId) {
      final res = await spotifyLct.getArtistById(id);
      artists.add(res);
    }
    debugPrint('===> [Spotify] Fetched ${artists.length} artists');
    return artists;
  }
}
