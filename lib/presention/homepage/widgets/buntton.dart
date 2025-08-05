import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_app/core/configs/assets/app_audio.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';

class LoveButton extends StatefulWidget {
  const LoveButton({super.key});

  @override
  State<LoveButton> createState() => _LoveButtonState();
}

class _LoveButtonState extends State<LoveButton> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      icon: SvgPicture.asset(
        _isFavorite ? AppVectors.loved : AppVectors.love,
        width: 24,
        height: 24,
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
  const PlayButton({super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    try {
      await _player.setAsset(AppAudio.khong_dau_nua_roi);
    } catch (e) {
      print('Lỗi khi load file nhạc: $e');
    }
  }

  void _togglePlayPause(PlayerState state) async {
    if (state.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final isPlaying = playerState?.playing ?? false;

        return IconButton(
          onPressed: () => _togglePlayPause(playerState ?? PlayerState(false, ProcessingState.idle)),
          icon: SvgPicture.asset(
            isPlaying ? AppVectors.pause_btn : AppVectors.play_btn,
            width: 40,
            height: 40,
          ),
        );
      },
    );
  }
}