// file: custom_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';

class LoveButton extends StatefulWidget {
  const LoveButton({Key? key}) : super(key: key);

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
  const PlayButton({Key? key}) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool _isPlay = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isPlay = !_isPlay;
          print('Đã ấn nút play/pause');
        });
      },
      icon: SvgPicture.asset(
        _isPlay ? AppVectors.pause_btn : AppVectors.play_btn,
        width: 40,
        height: 40,
      ),
    );
  }
}
