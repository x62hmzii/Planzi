import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;              // button ka label
  final VoidCallback onPressed;   // button press callback
  final Color color;              // button ka background color

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.yellow, // default color agar pass na karein
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color, // yaha use ho raha hai
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
    );
  }
}
