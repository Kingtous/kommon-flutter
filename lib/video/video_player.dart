import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VideoPlayer extends StatelessWidget {
  final String url;
  final bool isLive;
  final double ratio;

  const VideoPlayer(
      {Key? key, required this.url, this.isLive = false, this.ratio = 16 / 9})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: BetterPlayer(
        controller: BetterPlayerController(
            BetterPlayerConfiguration(
                autoPlay: true,
                autoDispose: true,
                allowedScreenSleep: false,
                errorBuilder: (cxt, msg) {
                  return Center(child: Text("$msg"));
                },
                autoDetectFullscreenDeviceOrientation: true,
                deviceOrientationsAfterFullScreen: const [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
                deviceOrientationsOnFullScreen: const [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]),
            betterPlayerDataSource: BetterPlayerDataSource(
                BetterPlayerDataSourceType.network, url,
                liveStream: isLive)),
      ),
    );
  }
}
