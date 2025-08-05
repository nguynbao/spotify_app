import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_app/core/configs/assets/app_audio.dart';
import 'package:spotify_app/core/configs/theme/app_theme.dart';
import 'package:spotify_app/firebase_options.dart';
import 'package:spotify_app/presention/splash/pages/splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("🔥 Firebase đã kết nối thành công");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Tuỳ chọn, có thể bỏ
  ]);
  // final player = AudioPlayer();
  // await player.setAsset(AppAudio.khong_dau_nua_roi); // nếu là asset
  // // await player.setUrl('https://yourdomain.com/song.mp3'); // nếu là URL
  // await player.play();
  runApp(const SpotifyApp());
}

class SpotifyApp extends StatelessWidget {
  const SpotifyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Spotify App',
          theme: AppTheme.darkTheme,
          home: const SplashPages(),
        );
      },
    );
  }
}
