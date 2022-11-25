import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      Helper.snack('error_saving_user'.tr, e.toString());
      return false;
    }
  }

  static Future<void> updateUser(Map<String, dynamic> data,
      {String? id}) async {
    try {
      await FirestoreService.instance
          .updateData(path: 'user/${id ?? uid}', data: data);
      debugPrint('===> [Firestore] User updated');
    } catch (e) {
      debugPrint("===> [Firestore] Error updating user: $e");
    }
  }

  static Future<User> getFriend(String friendUsername) async {
    final res = await FirestoreService.instance.getCollection(
      path: 'user/',
      builder: (data, documentId) => User.fromJson(data!, documentId),
      queryBuilder: (query) =>
          query.where('username', isEqualTo: friendUsername),
    );
    return res.first;
  }

  static Stream<User> get userStream =>
      FirestoreService.instance.documentStream(
        path: 'user/$uid',
        builder: (data, documentId) => User.fromJson(data!, documentId),
      );

  static Future<bool> usernameAlreadyExists(String username) async {
    final res = await FirestoreService.instance.getCollection(
      path: 'user/',
      builder: (data, documentId) => data!['username'],
      queryBuilder: (query) => query.where('username', isEqualTo: username),
    );

    debugPrint('===> [Firestore] usernameAlreadyExists: $res');
    return res.isNotEmpty;
  }

  static Future<bool> checkIfDocExists() => FirestoreService.instance
      .checkIfDocExists(collectionPath: 'user', docId: Auth.uid!);

  static Future<spotify.Track> getTrackById(String trackId,
      [bool showLog = true]) async {
    final track = await spotifyLct.getTrackById(trackId);

    if (showLog) debugPrint('===> [Spotify] Loaded track with id: $trackId');
    return track;
  }

  static Future<List<spotify.Track>> getTrackListByIds(
      List<String> trackIds) async {
    final tracks = await spotifyLct.getTrackListByIds(trackIds);

    debugPrint('===> [Spotify] Loaded ${tracks.length} tracks');
    return tracks;
  }

  static Future<List<spotify.Artist>> getArtistListFromLibary() async {
    final userCtrl = Get.find<UserController>();
    final artistIds = <String>[];

    for (int i = 0; i < userCtrl.user.value.artists.length; i++) {
      final id = userCtrl.user.value.artists[i]["artist"];
      if (!artistIds.contains(id)) artistIds.add(id!);
    }

    final artists = await spotifyLct.getArtistListByIds(artistIds);

    debugPrint('===> [Spotify] Loaded ${artists.length} artists');
    return artists;
  }

  static Future<List<spotify.Track>> getHistory() async {
    final userCtrl = Get.find<UserController>();

    final tracks = await spotifyLct.getTrackListByIds(userCtrl
        .user.value.history
        .map((e) => e['trackId'] as String)
        .toList());

    debugPrint('===> [Spotify] Loaded ${tracks.length} history');
    return tracks;
  }

  static Future<List<spotify.Track>> searchTrack(String input, int page) async {
    final tracks = await spotifyLct.searchTrack(input, page);

    tracks.removeWhere((t) =>
        t.album == null || t.album!.images == null || t.album!.images!.isEmpty);
    debugPrint(
        '===> [Spotify] Search found ${tracks.length} tracks on page $page');
    return tracks;
  }

  static Future<List<spotify.Artist>> searchArtist(String input) async {
    final artists = await spotifyLct.searchArtist(input);

    artists.removeWhere((a) => a.images == null || a.images!.isEmpty);
    debugPrint('===> [Spotify] Search found ${artists.length} artists');
    return artists;
  }

  static Future<List<spotify.Track>> searchTracksByArtist(
      String artistName, int page) async {
    final tracks = await spotifyLct.searchTracksByArtist(artistName, page);

    tracks.removeWhere((t) =>
        t.album == null || t.album!.images == null || t.album!.images!.isEmpty);
    return tracks;
  }

  static Future<List<spotify.Track>> getArtistTopTracks(String artistId) async {
    final tracks = await spotifyLct.getArtistTopTracks(artistId);

    tracks.removeWhere((t) =>
        t.album == null || t.album!.images == null || t.album!.images!.isEmpty);
    return tracks;
  }

  static Future<double> getTrackTempo(String trackId) async {
    final tempo = await spotifyLct.getTrackTempo(trackId);

    debugPrint('===> [Spotify] Tempo found: $tempo');
    return tempo;
  }
}
