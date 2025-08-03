import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/core/configs/button/app_button.dart';
import 'package:spotify_app/presention/lognin_or_lognup/bloc/auth_bloc.dart';
import 'package:spotify_app/presention/lognin_or_lognup/pages/lognin.dart';

final authBloc = AuthBloc();

class LognUp extends StatefulWidget {
  const LognUp({super.key});

  @override
  State<LognUp> createState() => _LognUpState();
}

class _LognUpState extends State<LognUp> {
  final fullName = TextEditingController();
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
                    _filedName("Full Name", fullName),
                    SizedBox(height: 20),
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
                      bool success = await authBloc.register(
                        email.text,
                        password.text,
                        fullName.text,
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng kí thành công')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LognIn(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng kí thất bại')),
                        );
                      }
                    },
                    title: 'Sign Up',
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
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        // Navigate to registration page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LognIn(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign In',
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
