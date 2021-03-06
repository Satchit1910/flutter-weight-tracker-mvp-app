import 'package:flutter/material.dart';

InputDecoration textInputDecoration = const InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0, color: Colors.deepOrangeAccent),
  ),
);
