import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_basic/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen(users);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(0, 139, 148, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/todo_splash.png',
              // height: 450,
              width: 300,
            ),
            Container(
              color: const Color.fromRGBO(0, 139, 148, 1),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        'TODO',
                        style: GoogleFonts.quicksand(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Seize the day!',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 241, 203, 203),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
