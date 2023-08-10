import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:spin_and_win/utils.dart';

class StarConfetti extends StatelessWidget {

  const StarConfetti({super.key, required this.controllerBottomCenter});
  final controllerBottomCenter;

  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: controllerBottomCenter,
              blastDirectionality: BlastDirectionality.explosive,
              blastDirection: -pi / 2,
              maxBlastForce: 100, // set a lower max blast force
              minBlastForce: 80, // set a lower min blast force
              emissionFrequency: 0.05,
              numberOfParticles: 40, // a lot of particles at once
              gravity: 1,
              colors: const [
                Color(0xff426651),
                Color(0xff6CA082),
                Color.fromARGB(255, 216, 239, 226)
              ],
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          );
  }
}