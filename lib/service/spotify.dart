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
}
