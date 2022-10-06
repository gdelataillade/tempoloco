import 'package:get_it/get_it.dart';
import 'package:tempoloco/service/spotify.dart';

Spotify spotifyLct = GetIt.instance<Spotify>();

Future<void> setupLocator() async {
  GetIt.instance.registerLazySingleton(() => Spotify());
  await spotifyLct.init();
}
