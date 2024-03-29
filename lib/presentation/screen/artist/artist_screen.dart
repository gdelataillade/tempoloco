import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/animation/fade_in.dart';
import 'package:tempoloco/presentation/common/widget/shader_mask.dart';
import 'package:tempoloco/presentation/screen/artist/artist_screen_state.dart';
import 'package:tempoloco/presentation/screen/artist/widget/header.dart';
import 'package:tempoloco/presentation/screen/artist/widget/tracks.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({Key? key}) : super(key: key);

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  final controller = ScrollController();
  late ArtistScreenState state;

  bool showArtistNameInAppBar = false;

  void detectEnd() {
    if (controller.position.atEdge) {
      if (controller.position.pixels != 0) {
        state.page += 1;
        state.loadTracks();
      }
    }
  }

  void scrollListener() {
    if (!state.initialized) return;

    if (controller.offset > state.headerSize &&
        !state.showArtistNameInAppBar.value) {
      state.showArtistNameInAppBar.value = true;
    } else if (controller.offset <= state.headerSize &&
        state.showArtistNameInAppBar.value) {
      state.showArtistNameInAppBar.value = false;
    }

    detectEnd();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ArtistScreenState>(
        init: ArtistScreenState(),
        builder: (_) {
          state = _;
          return Scaffold(
            appBar: state.showArtistNameInAppBar.value
                ? AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: state.showArtistNameInAppBar.value
                        ? FadeIn(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              state.artist.name!,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        : const SizedBox(),
                  )
                : null,
            body: SafeArea(
              child: Stack(
                children: [
                  BottomShaderMask(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: controller,
                      child: Column(
                        children: const [
                          Center(child: ArtistScreenHeader()),
                          ArtistScreenTracks(),
                        ],
                      ),
                    ),
                  ),
                  if (!state.showArtistNameInAppBar.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 4, left: 4),
                      child: BackButton(),
                    ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
