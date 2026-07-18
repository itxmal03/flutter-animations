import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class Example3 extends StatefulWidget {
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

const widthAndHeight = 100.0;

class _Example3State extends State<Example3> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;

  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 40),
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi);
  }

  @override
  void dispose() {
    super.dispose();
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();

    _zController
      ..reset()
      ..repeat();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              Text(
                '3D Rotating Cube',
                style: TextStyle(fontWeight: .bold, fontSize: 28),
              ),
              SizedBox(height: 150),
              AnimatedBuilder(
                animation: Listenable.merge([
                  _xController,
                  _yController,
                  _zController,
                ]),
                builder: (context, child) => Transform(
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      // back
                      Transform(
                        transform: Matrix4.identity()
                          ..translateByVector3(Vector3(0, 0, -widthAndHeight)),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.purple,
                        ),
                      ),
                      // left side
                      Transform(
                        alignment: .centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.red,
                        ),
                      ),
                      // right side
                      Transform(
                        alignment: .centerRight,
                        transform: Matrix4.identity()..rotateY(-pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.blue,
                        ),
                      ),
                      // front
                      Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: Colors.green,
                      ),
                      // top side
                      Transform(
                        alignment: .topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.orange,
                        ),
                      ),
                      // bottom side
                      Transform(
                        alignment: .bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        child: Container(
                          width: widthAndHeight,
                          height: widthAndHeight,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
