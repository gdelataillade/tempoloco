import 'package:spotify/spotify.dart';
import 'package:tempoloco/config.dart';

class Spotify {
  late SpotifyApi spotify;

  Future<void> init() async {
    final credentials = SpotifyApiCredentials(
      spotifyPublicKey,
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
        .get(input, types: [SearchType.track], market: 'fr')
        .getPage(15, 15 * page);

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
    final res = await spotify.search
        .get(input, types: [SearchType.artist], market: 'fr')
        .first(10);

    for (final page in res) {
      if (page.items!.isEmpty) continue;
      for (final item in page.items!) {
        if (item is Artist) artists.add(item);
      }
    }

    return artists;
  }
}
