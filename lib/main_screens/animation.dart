import 'package:flutter/material.dart';

class AnimatedBorderPage extends StatefulWidget {
  @override
  _AnimatedBorderPageState createState() => _AnimatedBorderPageState();
}

class _AnimatedBorderPageState extends State<AnimatedBorderPage> {
  bool isClicked = false; // State to toggle the animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Border Radius'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isClicked = !isClicked; // Toggle the animation on tap
            });
          },
          child: AnimatedContainer(
            width: 200,
            height: 200,
            duration: Duration(seconds: 1), // Duration of the animation
            curve: Curves.easeInOut, // Animation curve for smoothness
            decoration: BoxDecoration(
              color: isClicked ? Colors.blue : Colors.orange, // Background color change
              border: Border.all(
                color: isClicked ? Colors.green : Colors.red, // Border color change
                width: 5.0, // Border width
              ),
              borderRadius: BorderRadius.circular(isClicked ? 100 : 0), // Circular rounding animation
            ),
            child: Center(
              child: Text(
                'Tap me',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
