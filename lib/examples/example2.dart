import 'dart:math';

import 'package:flutter/material.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );

    path.close();
    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) {
    return Future.delayed(duration, this);
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;

  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _Example2State extends State<Example2> with TickerProviderStateMixin {
  late AnimationController _counterClockWiseAnimationContorller;
  late Animation<double> _counterClockWiseAnimation;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockWiseAnimationContorller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _counterClockWiseAnimation = Tween<double>(begin: 0, end: -(pi / 2))
        .animate(
          CurvedAnimation(
            parent: _counterClockWiseAnimationContorller,
            curve: Curves.bounceOut,
          ),
        );

    //flip animation
    _flipController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
    );

    _counterClockWiseAnimationContorller.addStatusListener((status) {
      if (_counterClockWiseAnimation.isCompleted) {
        _flipAnimation =
            Tween<double>(
              begin: _flipAnimation.value,
              end: _flipAnimation.value + pi,
            ).animate(
              CurvedAnimation(parent: _flipController, curve: Curves.bounceOut),
            );
        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener((status) {
      if (_flipAnimation.isCompleted) {
        _counterClockWiseAnimation =
            Tween<double>(
              begin: _counterClockWiseAnimation.value,
              end: _counterClockWiseAnimation.value + -(pi / 2),
            ).animate(
              CurvedAnimation(
                parent: _counterClockWiseAnimationContorller,
                curve: Curves.bounceOut,
              ),
            );
        _counterClockWiseAnimationContorller
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _counterClockWiseAnimationContorller.dispose();
    _flipController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _counterClockWiseAnimationContorller
      ..reset()
      ..forward.delayed(Duration(seconds: 1));
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              "Flutter Chained \n Animations",
              style: TextStyle(fontWeight: .bold, fontSize: 28),
              textAlign: .center,
            ),
            SizedBox(height: 50),
            AnimatedBuilder(
              animation: _counterClockWiseAnimationContorller,
              builder: (context, child) => Transform(
                alignment: .center,
                transform: Matrix4.identity()
                  ..rotateZ(_counterClockWiseAnimation.value),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) => Transform(
                        alignment: .centerRight,

                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(
                            side: CircleSide.left,
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            color: const Color(0xff1d4ed8),
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _flipController,
                      builder: (context, child) => Transform(
                        alignment: .centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(
                            side: CircleSide.right,
                          ),
                          child: Container(
                            width: 200,
                            height: 200,
                            color: const Color(0xff14b8a6),
                          ),
                        ),
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
}


// https://spiritsmassagecenter.pk/
// https://nuramaspa.site/
// https://sunshinemassagecenter.pk/