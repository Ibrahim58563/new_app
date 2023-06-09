import 'package:flutter/material.dart';

Widget mainCircleAvatar(IconData? icon) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: CircleAvatar(
      backgroundColor: Colors.grey.withOpacity(0.2),
      radius: 20.0,
      child: Icon(
        icon,
        color: Colors.black,
      ),
    ),
  );
}
