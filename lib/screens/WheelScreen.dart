import 'dart:async';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:spin_and_win/components/spin_button.dart';
import 'package:spin_and_win/components/stars.dart';
import 'package:spin_and_win/utils.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen>
    with SingleTickerProviderStateMixin {
  StreamController<int> selected = StreamController<int>();
  late ConfettiController controllerBottomCenter;
  late AnimationController animationController;
  late Animation animation;

  List<FortuneItem> fortuneItems = [];

  late int winner; // will be initialized after first spin and onwards

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fortuneItems = getWheelData(); // Gets the Widgets that Wheel accepts
    setBGAnimation(); // the background color animation
    controllerBottomCenter = ConfettiController(
        duration: const Duration(seconds: 2)); // the confetti controller
  }

  @override
  void dispose() {
    // Freeing up resources
    selected.close();
    controllerBottomCenter.dispose();
    animationController.dispose();
    animationController.removeListener(() {});
    animationController.removeStatusListener((status) {});

    super.dispose();
  }

  void setBGAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = ColorTween(
      begin: const Color.fromARGB(255, 213, 238, 219),
      end: const Color(0xff6CA082),
    ).animate(animationController);
    animationController.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(from: 1);
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.addListener(() {
      //if(controller.status==)
      setState(() {
        // log(animation.value);
      });
    });
  }

  // void startAnimation () {

  //   if (animationController.status == AnimationStatus.completed) {
  //     animationController.reverse(from: 1);
  //   } else if (animationController.status == AnimationStatus.dismissed) {
  //     log('inside dismiss to start the animation');
  //     animationController.forward();
  //   }

  //   // animationController.repeat(min: 3, max: 3, reverse: true);
  //   // animationController.stop();

  //   // setState(() {});
  // }

  void handleWinner() async {
    if (winner == 0) {
      _getFailDialog('You won Nothing');
    } else {
      controllerBottomCenter.play();
      await Future.delayed(const Duration(seconds: 2));
      controllerBottomCenter.stop();

      if (!mounted) return;
      _getSuccessDialog('Congratulations! You won a ${getItem(winner)}.');
    }
    setState(() {
      isLoading = false;
    });
  }

  void handleSpin() {
    setState(() {
      isLoading = true;
      winner = Fortune.randomInt(0, items.length);
      selected.add(
        winner,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(
        title: const Text(
          'Flutter Fortune Wheel',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff426651),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: isLoading
            ? null
            : (details) {
                handleSpin();
              },
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 36.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Want to try your Luck?",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 96, 143, 116),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: FortuneWheel(
                    indicators: _getIndicator(height),
                    animateFirst: false,
                    // onAnimationStart: startAnimation,
                    onAnimationEnd: handleWinner,
                    selected: selected.stream,
                    items: fortuneItems,
                  ),
                ),
              ],
            ),
            const SpinButton(),
            StarConfetti(controllerBottomCenter: controllerBottomCenter),
          ],
        ),
      ),
    );
  }

  _getIndicator(height) {
    return [
      FortuneIndicator(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Image.asset(
            'assets/f2.png',
            height: height * 0.2,
          ),
        ),
      ),
    ];
  }

  _getSuccessDialog(msg) => QuickAlert.show(
        context: context,
        backgroundColor: const Color.fromARGB(255, 202, 241, 212),
        type: QuickAlertType.success,
        title: 'Yayyy',
        text: msg,
      );

  _getFailDialog(msg) => QuickAlert.show(
        context: context,
        backgroundColor: const Color.fromARGB(255, 202, 241, 212),
        type: QuickAlertType.error,
        title: 'Oops...',
        text: msg,
      );
}
