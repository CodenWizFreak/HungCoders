import 'dart:math' as math;
import 'package:flutter/material.dart';

const int maxSeeds = 400;  // Increased the number of seeds

void main() {
  runApp(const Sunflower());
}

class Sunflower extends StatefulWidget {
  const Sunflower({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int seeds = maxSeeds;  // Use the updated number of seeds

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(elevation: 2),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sunflower'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SunflowerWidget(seeds, _animation),
              ),
              const SizedBox(height: 20),
              // Removed the slider and text widget
            ],
          ),
        ),
      ),
    );
  }
}

class SunflowerWidget extends StatelessWidget {
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 30; // Adjusted to fit more seeds in the same area
  static const size = 800.0;  // Size of the sunflower
  static final phi = (math.sqrt(5) + 1) / 2;
  static const frequency = 2; // Controls the number of crests and troughs

  final int seeds;
  final Animation<double> animation;

  const SunflowerWidget(this.seeds, this.animation, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final seedWidgets = <Widget>[];

        for (var i = 0; i < seeds; i++) {
          final theta = i * tau / phi;
          final r = math.sqrt(i) * scaleFactor;

          // Create the crest and trough effect
          final wave = math.sin(frequency * theta + animation.value * tau);
          final waveFactor = 1 + 0.5 * wave; // Controls the amplitude of the wave

          final x = r * math.cos(theta) * waveFactor;
          final y = -1 * r * math.sin(theta) * waveFactor;

          seedWidgets.add(Align(
            key: ValueKey(i),
            alignment: Alignment(x, y),
            child: const Dot(true),
          ));
        }

        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            height: size,
            width: size,
            child: Stack(children: seedWidgets),
          ),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  static const size = 5.0;
  static const radius = 3.0;

  final bool lit;

  const Dot(this.lit, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: lit ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const SizedBox(
        height: size,
        width: size,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaveAnimation(),
    );
  }
}

class WaveAnimation extends StatefulWidget {
  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  Path _path = Path();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            _path.reset();
            for (int i = 0; i < 360; i++) {
              double x = i.toDouble();
              double y = 100 + sin((x + _controller.value * 360) * pi / 180) * 50;
              if (i == 0) {
                _path.moveTo(x, y);
              } else {
                _path.lineTo(x, y);
              }
            }
            return CustomPaint(
              painter: WavePainter(_path),
              child: Container(
                width: 360,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  Path _path;

  WavePainter(this._path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
