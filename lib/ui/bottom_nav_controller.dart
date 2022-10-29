import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('This is bottom nav controller page'));
  }
}
