// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mouse Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MouseTracker(),
    );
  }
}

class MouseTracker extends StatefulWidget {
  const MouseTracker({super.key});

  @override
  State<MouseTracker> createState() => _MouseTrackerState();
}

class _MouseTrackerState extends State<MouseTracker> {
  double dx = .0;
  double dy = .0;
  bool isOut = true;

  @override
  void initState() {
    super.initState();
    // html.
    html.document.documentElement!.addEventListener('mouseleave', (event) {
      setState(() => isOut = true);
    });
    html.document.documentElement!.addEventListener('mouseenter', (event) {
      setState(() => isOut = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MouseRegion(
          onHover: (event) {
            dx = event.localPosition.dx;
            dy = event.localPosition.dy;
            setState(() {});
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: dy,
          left: dx,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isOut ? 0.0 : 9,
            width: isOut ? 0.0 : 9,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
