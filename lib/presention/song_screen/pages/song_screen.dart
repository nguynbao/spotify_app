import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/presention/mainscreen/pages/mainscreen.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  double _currentSliderValue = 0.0;
  final Duration _duration = Duration(seconds: 180);
  Duration _position = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff4D4D4D), Color(0xff121212)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _topBar(context),
                      SizedBox(height: 100),
                      _imgCenter(),
                      SizedBox(height: 100),
                      _controller(),
                      SizedBox(height: 40),
                    ],
                  ),
                  _lyrics(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const MainScreen(),
                transitionsBuilder: (_, animation, __, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: SvgPicture.asset(AppVectors.hide, height: 9, width: 18),
        ),
        Column(
          children: const [
            Text(
              'PLAYING FROM YOUR LIBRARY',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Liked Songs',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SvgPicture.asset(AppVectors.more, height: 19, width: 3),
      ],
    );
  }

  Widget _imgCenter() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: 364,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(AppImages.imgMain),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _controller() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kwaku the Traveller',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Black Sherif',
                  style: TextStyle(fontSize: 12, color: Colors.white60),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => print('lovee'),
              child: SvgPicture.asset(AppVectors.love, width: 24, height: 24),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// Timeline (Slider)
        Slider(
          min: 0,
          max: _duration.inSeconds.toDouble(),
          value: _currentSliderValue.clamp(0.0, _duration.inSeconds.toDouble()),
          onChanged: (value) {
            setState(() {
              _currentSliderValue = value;
              _position = Duration(seconds: value.toInt());
            });
          },
          activeColor: Colors.white,
          inactiveColor: Colors.white38,
        ),

        /// Time labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(_position),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              _formatDuration(_duration),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppVectors.shuffle),
            SvgPicture.asset(AppVectors.previous),
            SvgPicture.asset(AppVectors.pause_btn),
            SvgPicture.asset(AppVectors.next),
            SvgPicture.asset(AppVectors.repeat),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AppVectors.Device),
            Row(
              children: [
                SvgPicture.asset(AppVectors.Share),
                SizedBox(width: 30),
                SvgPicture.asset(AppVectors.Queue),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Widget _lyrics() {
    return Container(
      height: 394,
      decoration: BoxDecoration(
        color: Color(0xffFE4101),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Lyrics",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppVectors.expand,
                      // width: 24,
                      // height: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
