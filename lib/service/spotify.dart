import 'package:spotify/spotify.dart';
import 'package:tempoloco/config.dart';
import 'package:tempoloco/utils/helper.dart';

class Spotify {
  late SpotifyApi spotify;

  Future<void> init() async {
    final credentials = SpotifyApiCredentials(
      '30646375fdb84441acccb3c1097a9af3',
      spotifyPrivateKey,
    );
    spotify = SpotifyApi(credentials);
  }

  Future<Artist> getArtistById(String artistId) async {
    final artist = await spotify.artists.get(artistId);

    return artist;
  }

  Future<Track> getTrackById(String trackId) async {
    final track = await spotify.tracks.get(trackId);

    return track;
  }

  Future<List<Track>> searchTrack(String input, int page) async {
    final tracks = <Track>[];
    final res = await spotify.search
        .get(input, types: [SearchType.track]).getPage(15, 15 * page);

    for (final page in res) {
      if (page.items!.isEmpty) continue;
      for (final item in page.items!) {
        if (item is Track) tracks.add(item);
      }
    }

    return tracks;
  }

  Future<List<Artist>> searchArtist(String input) async {
    final artists = <Artist>[];
    final res =
        await spotify.search.get(input, types: [SearchType.artist]).first(10);

    for (final page in res) {
      if (page.items!.isEmpty) continue;
      for (final item in page.items!) {
        if (item is Artist) artists.add(item);
      }
    }

    return artists;
  }

  Future<List<Track>> searchTracksByArtist(String artistName, int page) async {
    final tracks = <Track>[];
    final res = await spotify.search
        .get(artistName, types: [SearchType.track]).getPage(10, 10 * page);

    for (final page in res) {
      if (page.items!.isEmpty) continue;
      for (final item in page.items!) {
        if (item is Track && item.artists!.first.name! == artistName) {
          tracks.add(item);
        }
      }
    }

    return tracks;
  }

  Future<List<Track>> getArtistTopTracks(String artistId) async {
    final res =
        await spotify.artists.getTopTracks(artistId, Helper.getLanguage());
    List<Track> tracks = res.toList();

    return tracks;
  }

  Future<double> getTrackTempo(String trackId) async {
    final res = await spotify.audioFeatures.get(trackId);

    return res.tempo ?? 0;
  }
}
