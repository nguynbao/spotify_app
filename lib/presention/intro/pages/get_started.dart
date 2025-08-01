import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/core/configs/button/app_button.dart';
import 'package:spotify_app/presention/lognin_or_lognup/pages/lognin_or_lognup.dart';

class GetStartedPages extends StatelessWidget {
  const GetStartedPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                AppVectors.logo2,
                width: 100,
                height: 100,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppButton(
                  title: 'Get Started',
                  onPressed: () {
                    // Navigate to the next page or perform an action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LogninOrLognup(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
