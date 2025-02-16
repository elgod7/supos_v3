import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
      // child: Lottie.asset(
      //   'assets/animation/login.json',
      //   width: 200,
      //   height: 200,
      //   animate: true,
      // ),
    );
  }
}
