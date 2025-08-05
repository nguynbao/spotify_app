import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerCubit extends Cubit<bool> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerCubit() : super(false); 

  Future<void> play(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      emit(true);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void pause() {
    _audioPlayer.pause();
    emit(false);
  }

  void stop() {
    _audioPlayer.stop();
    emit(false);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
