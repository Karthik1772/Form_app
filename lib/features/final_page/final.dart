import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinalPage extends StatefulWidget {
  const FinalPage({super.key});

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              // child: Lottie.asset('assets/success'),
              child: Image.asset("assets/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
