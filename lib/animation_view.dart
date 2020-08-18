import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationView extends StatefulWidget {
  @override
  _AnimationViewState createState() => _AnimationViewState();
}

class _AnimationViewState extends State<AnimationView> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 50), vsync: this);

    final curvedAnimation = CurvedAnimation(parent: animationController, 
    curve: Curves.bounceIn, reverseCurve: Curves.easeOut);

    animation = Tween<double>(begin: 0, end: 2* math.pi)
    .animate(curvedAnimation)
    ..addListener(() {
      setState((){
      });
    });

    animationController.forward();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Transform.rotate(
        angle: animation.value,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Image.asset('images/sorry.png'),
      ),),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}