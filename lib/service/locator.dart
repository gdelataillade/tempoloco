import 'package:get_it/get_it.dart';
import 'package:tempoloco/service/analytics.dart';
import 'package:tempoloco/service/remote.dart';
import 'package:tempoloco/service/spotify.dart';

Remote remoteLct = GetIt.instance<Remote>();
Spotify spotifyLct = GetIt.instance<Spotify>();
Analytics analyticsLct = GetIt.instance<Analytics>();

Future<void> setupLocator() async {
  GetIt.instance.registerSingleton(Remote());
  GetIt.instance.registerLazySingleton(() => Spotify());
  GetIt.instance.registerSingleton(Analytics());

  await spotifyLct.init();
  await remoteLct.init();
  await analyticsLct.init();
}
