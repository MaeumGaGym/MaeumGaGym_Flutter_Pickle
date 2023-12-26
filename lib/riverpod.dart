import 'package:chewie/chewie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final videoProvider =
    StateNotifierProvider<VideoStateNotifier, VideoState>((ref) {
  return VideoStateNotifier();
});

class VideoStateNotifier extends StateNotifier<VideoState> {
  VideoStateNotifier()
      : super(
          VideoState(
            isPlaying: true,
            heartState: false,
            index: 0,
          ),
        );

  void clickHeart() {
    state = VideoState(
      isPlaying: state.isPlaying,
      heartState: !state.heartState,
      index: state.index,
    );
  }

  void clickVideo() {
    state = VideoState(
      isPlaying: !state.isPlaying,
      heartState: state.heartState,
      index: state.index,
    );
  }

  void changePage(int value) {
    state = VideoState(
      isPlaying: state.isPlaying,
      heartState: state.heartState,
      index: value,
    );
  }

// ChewieController chewieController(int index) {
//   return ChewieController(
//     videoPlayerController: VideoPlayerController.networkUrl(
//       Uri.parse(state.data[index]["url"]),
//     ),
//     aspectRatio: 16 / 9,
//     showControls: false,
//     autoPlay: true,
//     looping: true,
//   );
// }
}

class VideoState {
  final bool isPlaying;
  final bool heartState;
  final int index;

  final List<Map<String, dynamic>> data = [
    {
      "url": "https://video-macos2.pokabook.kr/90c7e772/index.m3u8",
    },
    {
      "url": "https://video-macos2.pokabook.kr/90c7e772/index.m3u8",
    },
    {
      "url": "https://video-macos2.pokabook.kr/90c7e772/index.m3u8",
    },
    {
      "url": "https://video-macos2.pokabook.kr/90c7e772/index.m3u8",
    },
  ];

  VideoState({
    required this.isPlaying,
    required this.heartState,
    required this.index,
  });
}
