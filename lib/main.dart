import 'package:flutter/material.dart';

import 'package:maeumgagym_flutter_pickle/riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Consumer(builder: (context, ref, child) {
        var state = ref.watch(videoProvider);

        return PageView.builder(
          itemCount: state.data.length,
          itemBuilder: (context, index) {
            var chwieController = ChewieController(
              videoPlayerController: VideoPlayerController.networkUrl(
                Uri.parse(state.data[state.index]["url"]),
              ),
              aspectRatio: 16 / 9,
              showControls: false,
              autoPlay: true,
              looping: true,
            );

            return SizedBox(
              height: MediaQuery.of(context).size.height - 88,
              child: Stack(
                children: [
                  /// Video
                  GestureDetector(
                    onTap: () {
                      ref.read(videoProvider.notifier).clickVideo();
                      state.isPlaying
                          ? chwieController.play()
                          : chwieController.pause();
                    },
                    onDoubleTap: () =>
                        ref.read(videoProvider.notifier).clickHeart(),
                    child: Chewie(controller: chwieController),
                  ),

                  /// Camera Icon
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Image.asset('assets/camera.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 391),
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(videoProvider.notifier).clickHeart();
                                },
                                child: Image.asset(
                                  'assets/heart.png',
                                  color: ref.watch(videoProvider).heartState
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      })),
      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          ],
        ),
      ),
    );
  }
}
