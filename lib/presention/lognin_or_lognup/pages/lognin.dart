import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/core/configs/button/app_button.dart';
import 'package:spotify_app/presention/lognin_or_lognup/bloc/auth_bloc.dart';
import 'package:spotify_app/presention/mainscreen/pages/mainscreen.dart';
import 'package:spotify_app/presention/lognin_or_lognup/pages/lognup.dart';

final authBloc = AuthBloc();

class LognIn extends StatefulWidget {
  const LognIn({super.key});

  @override
  State<LognIn> createState() => _LognInState();
}

class _LognInState extends State<LognIn> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(AppVectors.logo, width: 100, height: 100),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _filedName("Email", email),
                    SizedBox(height: 20),
                    _filedName("Password", password),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    onPressed: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const MainScreen(),
                      //   ),
                      // );
                      bool success = await authBloc.login(
                        email.text,
                        password.text,
                      );
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng nhap thất bại')),
                        );
                      }
                    },
                    title: 'Login',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        // Navigate to registration page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LognUp(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filedName(String label, TextEditingController input) {
    return Column(
      children: [
        TextField(
          controller: input,
          decoration: InputDecoration(labelText: label),
        ),
      ],
    );
  }
}
