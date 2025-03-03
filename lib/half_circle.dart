import 'dart:math';
import 'package:flutter/material.dart';
import 'app_theme.dart';


class HalfCircle extends StatefulWidget {
  final double pizzaScale;
  final Curve pizzaCurve;

  const HalfCircle({
    super.key,
    required this.pizzaScale,
    required this.pizzaCurve,
  });

  @override
  State<HalfCircle> createState() => _HalfCircleState();
}

class _HalfCircleState extends State<HalfCircle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.5 * pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void didUpdateWidget(HalfCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pizzaScale != oldWidget.pizzaScale) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final diameter = screenHeight * 0.6;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: diameter / 2,
        height: diameter,
        decoration: BoxDecoration(
          color: primaryDarkColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(diameter),
            bottomLeft: Radius.circular(diameter),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(diameter),
            bottomLeft: Radius.circular(diameter),
          ),
          child: Transform.translate(
            offset: Offset(screenWidth > 600 ? 200 : 150, 0,),
            child: OverflowBox(
              minWidth: 0,
              maxWidth: double.infinity,
              child: AnimatedBuilder(
                animation: _rotation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateZ(_rotation.value),
                    child: AnimatedContainer(
                      width: diameter * widget.pizzaScale,
                      duration: const Duration(milliseconds: 450),
                      curve: widget.pizzaCurve,
                      child: Image.asset(
                        'assets/pizza.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
