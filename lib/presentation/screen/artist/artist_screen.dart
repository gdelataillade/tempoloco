import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/presentation/screen/artist/widget/header.dart';
import 'package:tempoloco/presentation/screen/artist/widget/tracks.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: GetBuilder<ArtistScreenState>(
          init: ArtistScreenState(),
          builder: (state) {
            return Column(
              children: const [
                ArtistScreenHeader(),
                Expanded(child: ArtistScreenTracks()),
              ],
            );
          }),
    );
  }
}
