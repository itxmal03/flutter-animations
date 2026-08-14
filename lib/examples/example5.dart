import 'package:flutter/material.dart';

class Example5 extends StatefulWidget {
  const Example5({super.key});

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  static const defaultWidth = 100.0;
  var isZoom = false;
  var zoomButtonTxt = "Zoom In";
  var _width = defaultWidth;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      appBar: AppBar(
        title: Text('Implicit Animations'),
        centerTitle: true,
        backgroundColor: Colors.grey.withValues(alpha: 0.45),
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 370,
              ), // considered more suitable animation
              width: _width,
              curve: _curve,
              child: Image.asset('assets/images/image.png'),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                isZoom = !isZoom;
                zoomButtonTxt = isZoom ? "Zoom Out" : "Zoom In";
                _width = isZoom
                    ? MediaQuery.of(context).size.width
                    : defaultWidth;
                _curve = isZoom ? Curves.easeInOut : Curves.easeOutCubic;
              });
            },
            child: Text(zoomButtonTxt),
          ),
        ],
      ),
    );
  }
}
