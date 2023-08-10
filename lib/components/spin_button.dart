import 'package:flutter/material.dart';

class SpinButton extends StatelessWidget {
  const SpinButton({super.key,});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xff426651),
          border: Border.all(
            color: const Color(0xff426651),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Image.asset(
          'assets/f1.png',
          width: width * 0.2,
          height: height * 0.2,
        ),
      ),
    );
  }
}
