import 'package:flutter/material.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/configs/button/app_button.dart';
import 'package:spotify_app/presention/lognin_or_lognup/pages/lognin.dart';
import 'package:spotify_app/presention/lognin_or_lognup/pages/lognup.dart';

class LogninOrLognup extends StatefulWidget {
  const LogninOrLognup({super.key});

  @override
  State<LogninOrLognup> createState() => _LogninOrLognupState();
}

class _LogninOrLognupState extends State<LogninOrLognup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.logo, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LognIn(),
                          ),
                        );
                      },
                      title: 'Login',
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LognUp(),
                          ),
                        );
                      },
                      child: const Text('Signup'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
